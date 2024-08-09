const { hookable } = require('@evershop/evershop/src/lib/util/hookable');
const {
  startTransaction,
  commit,
  rollback,
  select,
  del
} = require('@evershop/postgres-query-builder');
const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');

async function deleteWishlistData(id, connection) {
  await del('wishlist').where('id', '=', id).execute(connection);
}

/**
 * Delete wishlist service. This service will delete a tag with all related data
 * @param {String} id
 * @param {Object} context
 */
async function deleteWishlist(id, context) {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const query = select().from('wishlist');
   

    const wishlist = await query.where('id', '=', id).load(connection);
    if (!wishlist) {
      throw new Error('Invalid wishlist id');
    }
    await hookable(deleteWishlistData, { ...context, connection, wishlist })(
      id,
      connection
    );
    await commit(connection);
    return wishlist;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}

module.exports = async (uuid, context) => {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const hookContext = {
      connection
    };
    // Make sure the context is either not provided or is an object
    if (context && typeof context !== 'object') {
      throw new Error('Context must be an object');
    }
    // Merge hook context with context
    Object.assign(hookContext, context);
    const product = await hookable(deleteWishlist, hookContext)(
      uuid,
      connection
    );
    await commit(connection);
    return product;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
};
