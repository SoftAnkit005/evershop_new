const getWishlistData = require('../../services/getWishlistData');

module.exports = async function getWishlist(request, response) {
    try 
    {
      const wishlist = await getWishlistData({
        routeId: request.currentRoute.id
      });
      if (wishlist) 
      {
        response.json(wishlist);
      } else 
      {
        response.status(404).json({ error: 'Wishlist not found' });
      }
    } catch (e)
    {
      response.status(404).json({ error: 'Somenthig went wrong' });
    }

};