const {
  INTERNAL_SERVER_ERROR
} = require('@evershop/evershop/src/lib/util/httpStatus');
const createTag = require('../../services/tag/createTag');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate, next) => {
  const result = "test dayta";
  return result;
  try {
    const { body: { name, product_id } } = request;
    // Insert the comment into the database
    await createTag('tag')
      .given({
        name,
        product_id
      })
      .execute(INTERNAL_SERVER_ERROR);
    response.json({ success: true });


  } catch (error) {
    next(error);
  }
};
