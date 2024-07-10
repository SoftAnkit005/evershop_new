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

async function deleteReviewData(id, connection) {
  await del('reviews').where('id', '=', id).execute(connection);
}

/**
 * Delete review service. This service will delete a reviews with all related data
 * @param {String} id
 * @param {Object} context
 */
async function deleteReview(id, context) {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const query = select().from('reviews');
   

    const review = await query.where('id', '=', id).load(connection);
    if (!review) {
      throw new Error('Invalid review id');
    }
    await hookable(deleteReviewData, { ...context, connection, review })(
      id,
      connection
    );
    await commit(connection);
    return review;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}

module.exports = async (id, context) => {
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
    const review = await hookable(deleteReview, hookContext)(
      id,
      connection
    );
    await commit(connection);
    return review;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
};
