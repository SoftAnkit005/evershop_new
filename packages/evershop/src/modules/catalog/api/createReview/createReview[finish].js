const createReview = require('../../services/review/createReview');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate) => {

  // const result = "api done";
  const result = await createReview(request.body, {
    routeId: request.currentRoute.id
  });

  return result;
};
