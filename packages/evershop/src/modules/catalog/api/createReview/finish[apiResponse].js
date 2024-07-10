const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');
const { OK } = require('@evershop/evershop/src/lib/util/httpStatus');

// eslint-disable-next-line no-unused-vars
module.exports = async (request, response, delegate, next) => {
  const review = await delegate.createReview;
  response.status(OK);
  response.json({
    data: {
      ...review,
      links: [
        {
          rel: 'reviewGrid',
          href: buildUrl('reviewGrid'),
          action: 'GET',
          types: ['text/xml']
        }
      ]
    }
  });
};
