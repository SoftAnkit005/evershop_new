const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');
const { OK } = require('@evershop/evershop/src/lib/util/httpStatus');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate, next) => {
  const tag = await delegate.createTag;
  response.status(OK);
  response.json({
    data: {
      ...tag,
      links: [
        {
          rel: 'tagGrid',
          href: buildUrl('tagGrid'),
          action: 'GET',
          types: ['text/xml']
        }
      ]
    }
  });
};
