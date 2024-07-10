const getReviewData = require('../../services/getReviewData');

module.exports = async function getReview(request, response) {
    try 
    {
      const review = await getReviewData({
        routeId: request.currentRoute.id
      });
      if (review) 
      {
        response.json(review);
      } else 
      {
        response.status(404).json({ error: 'Review not found' });
      }
    } catch (e)
    {
      response.status(404).json({ error: 'Somenthig went wrong' });
    }

};