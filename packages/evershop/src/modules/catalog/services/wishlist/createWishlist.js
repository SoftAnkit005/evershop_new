const { hookable } = require('@evershop/evershop/src/lib/util/hookable');
const {
  getValueSync,
  getValue
} = require('@evershop/evershop/src/lib/util/registry');
const {
  startTransaction,
  commit,
  rollback,
  insert,
  select,
  del
  // insertOnUpdate
} = require('@evershop/postgres-query-builder');
const {
  getConnection
} = require('@evershop/evershop/src/lib/postgres/connection');
const { getAjv } = require('../../../base/services/getAjv');
const wishlistDataSchema = require('./wishlistDataSchema.json');

function validateWishlistDataBeforeInsert(data) {
  
  const ajv = getAjv();
  wishlistDataSchema.required = [    
    'user_id',
    'product_id'
  ];
  const jsonSchema = getValueSync(
    'createWishlistDataJsonSchema',
    wishlistDataSchema
  );
  const validate = ajv.compile(jsonSchema);
  const valid = validate(data);
  if (valid) {
    return data;
  } else {
    throw new Error(validate.errors[0].message);
  }
}



async function insertWishlistData(data, connection) {

    const existingEntry = await select()
      .from('wishlist')
      .where('user_id', '=', data.user_id)
      .and('product_id', '=', data.product_id)
      .load(connection);
  if (!existingEntry) {
  
   
   await insert('wishlist').given(data).execute(connection);
      return {
      status: 'true',
      message: 'Wishlist item inserted successfully.'
      };
      
  } else {
      
    await del('wishlist')
        .where('user_id', '=', data.user_id)
        .and('product_id', '=', data.product_id)
      .execute(connection);
    return {
      status: 'false',
      message: 'Existing wishlist item deleted successfully.'
    };
    
    }

}

/**
 * Create wishlist service. This service will create a wishlist with all related data
 * @param {Object} data
 * @param {Object} context
 */
async function createWishlist(data, context) {

  const connection = await getConnection();
  await startTransaction(connection);
  try {
    const wishlistData = await getValue('wishlistDataBeforeCreate', data);
   
    // Validate Wishlist data
    validateWishlistDataBeforeInsert(wishlistData);

    // Insert Wishlist data
    const wishlist = await hookable(insertWishlistData, {
      connection,
      ...context
    })(wishlistData, connection);
  
    await commit(connection);
    return wishlist;
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
  const tag = await hookable(createWishlist, context)(data, context);
  return tag;
};