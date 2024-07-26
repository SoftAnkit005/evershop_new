const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const {
  startTransaction,
  rollback,
  execute
} = require('@evershop/postgres-query-builder');
const { pool } = require('@evershop/evershop/src/lib/postgres/connection');

async function getSearchData({ keyword }) {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    // Select products with the given keyword and join with categories to get the category names
    // const productsWithCategories = await select('product_description.name as product_name', 'categories.name as category_name')
    //   .from('product')
    //   .join('category_description', 'category_description.category_description_category_id', 'product.category_id')
    //   .join('product_description', 'product_description.product_description_product_id', 'product.product_id')
    //   .where('product_description.name', 'ilike', `%${keyword}%`)
    //   .execute(connection);
      const recursiveQuery =  `SELECT 
              product_description.name as product_name, 
              category_description.name as category_name
          FROM 
              product
          INNER JOIN 
              category_description ON category_description.category_description_category_id = product.category_id
          INNER JOIN 
              product_description ON product_description.product_description_product_id = product.product_id
          WHERE 
              product_description.name ILIKE '%${keyword}%'`;
      const productsWithCategories = await execute(pool, recursiveQuery);
    return productsWithCategories;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}
module.exports = getSearchData;
