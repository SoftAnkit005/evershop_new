const { select, value } = require('@evershop/postgres-query-builder');
const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');

module.exports = {
  Query: {
    menu: async (root, _, { pool }) => {
      const query = select('category_id')
        .select('name')
        .select('uuid')
        .select('request_path')
        .select('url_key')
        .select('parent_id')
        .select('position')
        .from('category', 'cat');
      query
        .leftJoin('category_description', 'des')
        .on('cat.category_id', '=', 'des.category_description_category_id');
      query
        .leftJoin('url_rewrite', 'url')
        .on('url.entity_uuid', '=', 'cat.uuid')
        .and('url.entity_type', '=', value('category'));
      query
        .where('cat.status', '=', 1)
        .and('cat.include_in_nav', '=', 1)
        .and('des.url_key', 'IS NOT NULL', null)
        .and('des.url_key', '!=', '');
      


      
      const items = await query.execute(pool);

      const menuItems = items.map((i) => ({
        category_id: i.category_id,
        name: i.name,
        url: i.request_path || buildUrl('categoryView', { uuid: i.uuid }),
        parent_id: i.parent_id === null ? 0 : i.parent_id,
        children: [],
        position:i.position === null ? 0 : i.position,
      }));

      const menuMap = {};
      menuItems.forEach(item => {
        menuMap[item.category_id] = item;
      });

      const tree = [];
      menuItems.forEach(item => {
        
        if (item.parent_id === 0) {
          tree.push(item);
        } else {
          const parentItem = menuMap[item.category_id];
          tree.forEach(treeitem => {
            if(treeitem.category_id === parentItem.parent_id)
              {
                treeitem.children.push(item);
              }
          });
        
        }
      });

      return { items: tree };
    }
  }
};
