const getSearchData = require('../../services/getSearchData');

module.exports = async function createSearch (request, response) {
  try {
    
    const keyword = request.body.keyword || ''; // Get the search keyword from the query parameters
    
    const search = await getSearchData({
      routeId: request.currentRoute.id,
      keyword: keyword // Pass the keyword to the getSearchData function
    });
   
    if (search) {
      
      response.status(200).json(search.rows);
    } else {
      response.status(404).json({ error: 'Search not found' });
    }
  } catch (e) {
   
    response.status(404).json({ error: 'Something went wrong' });
  }
};
