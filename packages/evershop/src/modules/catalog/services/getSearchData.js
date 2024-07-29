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
      // const recursiveQuery =  `SELECT 
      //         product_description.name as product_name, 
      //         category_description.name as category_name
      //     FROM 
      //         product
      //     INNER JOIN 
      //         category_description ON category_description.category_description_category_id = product.category_id
      //     INNER JOIN 
      //         product_description ON product_description.product_description_product_id = product.product_id
      //     WHERE 
      //         product_description.name ILIKE '%${keyword}%'`;
      const recursiveQuery =  `SELECT 
      product_description.name AS product_name, 
      category_description.name AS category_name,
      parent_category_description.name AS parent_category_name,
      product_description.url_key AS product_url_key,
      category_description.url_key AS category_url_key,
      parent_category_description.url_key AS parent_category_url_key
        FROM 
            product
        INNER JOIN 
            category ON category.category_id = product.category_id
        INNER JOIN 
            category_description ON category_description.category_description_category_id = category.category_id
        INNER JOIN 
            product_description ON product_description.product_description_product_id = product.product_id
        LEFT JOIN 
            category AS parent_category ON parent_category.category_id = category.parent_id
        LEFT JOIN 
            category_description AS parent_category_description ON parent_category_description.category_description_category_id = parent_category.category_id
        WHERE 
            product_description.name ILIKE '%${keyword}%';`;
      const productsWithCategories = await execute(pool, recursiveQuery);
    return productsWithCategories;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}
module.exports = getSearchData;
