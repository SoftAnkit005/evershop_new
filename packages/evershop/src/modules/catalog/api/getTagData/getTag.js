const getTagData = require('../../services/getTagData');

module.exports = async function getTag(request, response) {
    try 
    {
      const tag = await getTagData({
        routeId: request.currentRoute.id
      });
      if (tag) 
      {
        response.json(tag);
      } else 
      {
        response.status(404).json({ error: 'Tag not found' });
      }
    } catch (e)
    {
      response.status(404).json({ error: 'Somenthig went wrong' });
    }

};