const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const {
  startTransaction,
  rollback,
  select
} = require('@evershop/postgres-query-builder');

async function getReviewData() {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const review = select().from('reviews').execute(connection);
    if (!review) {
      throw new Error('Invalid review id');
    }
    return review;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}
module.exports = getReviewData;