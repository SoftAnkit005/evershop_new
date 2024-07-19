const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const {
  startTransaction,
  rollback,
  select
} = require('@evershop/postgres-query-builder');

async function getCouponData() {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const coupon = select().from('coupon').execute(connection);
    if (!coupon) {
      throw new Error('Invalid coupon id');
    }
    return coupon;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}
module.exports = getCouponData;