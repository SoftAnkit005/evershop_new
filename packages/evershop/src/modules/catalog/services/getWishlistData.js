const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const {
  startTransaction,
  rollback,
  select
} = require('@evershop/postgres-query-builder');

async function getWishlistData() {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const wishlist = select().from('wishlist').execute(connection);
    if (!wishlist) {
      throw new Error('Invalid wishlist id');
    }
    return wishlist;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}
module.exports = getWishlistData;