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
const reviewDataSchema = require('./reviewDataSchema.json');

function validateReviewDataBeforeInsert(data) {
  const ajv = getAjv();
  reviewDataSchema.required = [
    'name',
    'view'
  ];
  const jsonSchema = getValueSync(
    'createReviewDataJsonSchema',
    reviewDataSchema
  );
  const validate = ajv.compile(jsonSchema);
  const valid = validate(data);
  if (valid) {
    return data;
  } else {
    throw new Error(validate.errors[0].message);
  }
}



async function insertReviewData(data, connection) {


  const review = await insert('reviews').given(data).execute(connection);
  // return review;


  return {
    ...review
  };
}

/**
 * Create Review service. This service will create a review with all related data
 * @param {Object} data
 * @param {Object} context
 */
async function createReview(data, context) {

  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const reviewData = await getValue('reviewDataBeforeCreate', data);
   
    // Validate Review data
    validateReviewDataBeforeInsert(reviewData);

    // Insert Review data
    const review = await hookable(insertReviewData, {
      connection,
      ...context
    })(reviewData, connection);
  
    await commit(connection);
    return review;
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
  const review = await hookable(createReview, context)(data, context);
  return review;
};