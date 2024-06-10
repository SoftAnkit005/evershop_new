const { buildFilterFromUrl } = require('@evershop/evershop/src/lib/util/buildFilterFromUrl');
const { setContextValue } = require('../../../../graphql/services/contextHelper');

module.exports = (request, response) => {
  setContextValue(request, 'pageInfo', {
    title: 'Tag',
    description: 'Tag'
  });
  setContextValue(request, 'filtersFromUrl', buildFilterFromUrl(request));
};
