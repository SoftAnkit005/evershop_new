const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const {
  startTransaction,
  rollback,
  select
} = require('@evershop/postgres-query-builder');


async function getProductTagData(product_id) {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const query = select().from('tags');
   

    const tag = await query.where('product_id', '=', product_id).load(connection);
    if (!tag) {
      throw new Error('Invalid Product id');
    }
  
    return tag;
  } catch (e) {
    await rollback(connection);
    throw e;
  } finally {
    // Ensure to release the connection (assuming there's a release method in your connection object)
    await connection.release();
  }
}
module.exports = getProductTagData;