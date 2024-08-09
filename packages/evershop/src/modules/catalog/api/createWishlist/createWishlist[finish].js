const createWishlist = require('../../services/wishlist/createWishlist');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate) => {
  const result = await createWishlist(request.body, {
    routeId: request.currentRoute.id
  });
  
 return result;
};
