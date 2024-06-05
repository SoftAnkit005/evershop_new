const { hookable } = require('@evershop/evershop/src/lib/util/hookable');
const {
  getValueSync,
  getValue
} = require('@evershop/evershop/src/lib/util/registry');
const {
  startTransaction,
  commit,
  rollback,
  insert
  // select,
  // update,
  // insertOnUpdate
} = require('@evershop/postgres-query-builder');
const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const { getAjv } = require('../../../base/services/getAjv');
const tagDataSchema = require('./tagDataSchema.json');

function validateTagDataBeforeInsert(data) {
  const ajv = getAjv();
  tagDataSchema.required = [
    'name',
    'product_id'
  ];
  const jsonSchema = getValueSync(
    'createTagDataJsonSchema',
    tagDataSchema
  );
  const validate = ajv.compile(jsonSchema);
  const valid = validate(data);
  if (valid) {
    return data;
  } else {
    throw new Error(validate.errors[0].message);
  }
}



async function insertTagData(data, connection) {
  const tag = await insert('tag').given(data).execute(connection);


  return {
    ...tag
  };
}

/**
 * Create Tag service. This service will create a tag with all related data
 * @param {Object} data
 * @param {Object} context
 */
async function createTag(data, context) {
  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const tagData = await getValue('tagDataBeforeCreate', data);

    // Validate Tag data
    validateTagDataBeforeInsert(tagData);

    // Insert Tag data
    const tag = await hookable(insertTagData, {
      connection,
      ...context
    })(tagData, connection);

    await commit(connection);
    return tag;
  } catch (e) {
    await rollback(connection);
    throw e;
  }
}

module.exports = async (data, context) => {
  // Make sure the context is either not provided or is an object
  if (context && typeof context !== 'object') {
    throw new Error('Context must be an object');
  }
  const tag = await hookable(createTag, context)(data, context);
  return tag;
};