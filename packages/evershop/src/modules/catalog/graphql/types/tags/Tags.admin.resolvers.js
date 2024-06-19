const { select } = require('@evershop/postgres-query-builder');
const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');

module.exports = {
  Tag: {
    editUrl: (tag) => buildUrl('tagEdit', { id: tag.id }),
    updateApi: (tag) => buildUrl('updateTag', { id: tag.id }),
    deleteApi: (tag) => buildUrl('deleteTag', { id: tag.id }),
    addProductUrl: (tag) =>
      buildUrl('addProductToTag', { id: tag.id })
  },
  Product: {
    removeFromTagUrl: async (product, _, { pool }) => {
      if (!product.id) {
        return null;
      } else {
        const tag = await select()
          .from('tags')
          .where('product_id', '=', product.id)
          .load(pool);
        return buildUrl('removeFromTagUrl', {
          id: tag.id,
          product_id: tag.product_id
        });
      }
    }
  }
};
