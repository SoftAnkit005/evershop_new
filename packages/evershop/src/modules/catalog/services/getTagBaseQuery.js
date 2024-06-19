const { select } = require('@evershop/postgres-query-builder');

async function getTagBaseQuery() {
    const query = select('tags.name', 'tags.id','tags.product_id').select('product_description.name','productName').from('tags');  
    query
    .innerJoin('product_description')
    .on(
      'tags.product_id',
      '=',
      'product_description.product_description_product_id'
    );
    return query;
    // const query = select('tags.id', 'tags.name', 'product.sku');
    //   query.select('product_description.name', 'product_name').from('tags');
    //   query.innerJoin('product').on('tags.product_id', '=', 'product.product_id');
    //   query.innerJoin('product_description').on('product_description.product_description_product_id', '=', 'tags.product_id');

    // return query;
}

module.exports = { getTagBaseQuery }; // Export as an object with the function
