const createTag = require('../../services/tag/createTag');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate) => {

  // const result = "api done";
  const result = await createTag(request.body, {
    routeId: request.currentRoute.id
  });

  return result;
};
