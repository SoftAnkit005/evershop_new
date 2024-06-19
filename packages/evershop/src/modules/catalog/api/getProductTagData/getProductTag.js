const getProductTagData = require('../../services/getProductTagData');

module.exports = async function getTag(request, response) {
    try 
    {
      const { id } = request.params;

      const tag = await getProductTagData(id,{
        routeId: request.currentRoute.id
      });
      if (tag) 
      {
        response.json(tag);
      } else 
      {
        response.status(404).json({ error: 'Product Tag not found' });
      }
    } catch (e)
    {
      response.status(404).json({ error: 'Somenthig went wrong' });
    }

};