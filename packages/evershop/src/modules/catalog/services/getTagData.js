const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const {
  startTransaction,
  rollback,
  select
} = require('@evershop/postgres-query-builder');

async function getTagData() {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const tag = select().from('tags').execute(connection);
    if (!tag) {
      throw new Error('Invalid tag id');
    }
    return tag;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}
module.exports = getTagData;