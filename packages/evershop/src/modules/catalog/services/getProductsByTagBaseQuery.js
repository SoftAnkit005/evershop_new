const { execute, select } = require('@evershop/postgres-query-builder');
const { pool } = require('@evershop/evershop/src/lib/postgres/connection');
const { getProductsBaseQuery } = require('./getProductsBaseQuery');

module.exports.getProductsByTagBaseQuery = async (id, fromTags = false) => {
  const query = getProductsBaseQuery();

  if (!fromTags) {
    // When not fetching from tags, fetch the product by its id directly
    query.where('product.product_id', '=', id);
  } else {
    // Use a CTE (Common Table Expression) for the recursive query
    const recursiveQuery = `
      WITH RECURSIVE tagged_products AS (
        SELECT product.* FROM product
        INNER JOIN tags ON product.product_id = tags.product_id
        WHERE tags.id = ${id}
        UNION
        SELECT pr.* FROM product pr
        INNER JOIN tags t ON pr.product_id = t.product_id
        INNER JOIN tagged_products tp ON tp.product_id = t.product_id
      )
      SELECT * FROM tagged_products;
    `;

    const productsQuery = await execute(pool, recursiveQuery);
    const products = productsQuery.rows;
    const productIds = products.map(product => product.product_id);

    // Adjust the main query to fetch products by the gathered product IDs
    if (productIds.length > 0) {
      query.where('product.product_id', 'IN', productIds);
    } else {
      query.where('product.product_id', '=', '-1'); // Return empty result if no products found
    }
  }

  return query;
};
