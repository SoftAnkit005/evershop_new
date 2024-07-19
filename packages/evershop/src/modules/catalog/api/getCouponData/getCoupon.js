const getCouponData = require('../../services/getCouponData');

module.exports = async function getCoupon(request, response) {
    try 
    {
      const coupon = await getCouponData({
        routeId: request.currentRoute.id
      });
      if (coupon) 
      {
        response.json(coupon);
      } else 
      {
        response.status(404).json({ error: 'Coupon not found' });
      }
    } catch (e)
    {
      response.status(404).json({ error: 'Somenthig went wrong' });
    }

};