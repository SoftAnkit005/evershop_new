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

async function deleteTagData(id, connection) {
  await del('tags').where('id', '=', id).execute(connection);
}

/**
 * Delete tag service. This service will delete a tag with all related data
 * @param {String} id
 * @param {Object} context
 */
async function deleteTag(id, context) {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const query = select().from('tags');
   

    const tag = await query.where('id', '=', id).load(connection);
    if (!tag) {
      throw new Error('Invalid tag id');
    }
    await hookable(deleteTagData, { ...context, connection, tag })(
      id,
      connection
    );
    await commit(connection);
    return tag;
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
    const product = await hookable(deleteTag, hookContext)(
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
