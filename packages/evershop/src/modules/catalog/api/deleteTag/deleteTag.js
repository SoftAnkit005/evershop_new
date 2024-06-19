const {
  OK,
  INTERNAL_SERVER_ERROR
} = require('@evershop/evershop/src/lib/util/httpStatus');
const deleteTag = require('../../services/tag/deleteTag');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate, next) => {
  try {
    const { id } = request.params;
    const product = await deleteTag(id, {
      routeId: request.currentRoute.id
    });
    response.status(OK);
    response.json({
      data: product
    });
  } catch (e) {
    response.status(INTERNAL_SERVER_ERROR);
    response.json({
      error: {
        status: INTERNAL_SERVER_ERROR,
        message: e.message
      }
    });
  }
};
