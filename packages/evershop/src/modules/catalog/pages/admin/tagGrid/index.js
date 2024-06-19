const { buildFilterFromUrl } = require('@evershop/evershop/src/lib/util/buildFilterFromUrl');
const { setContextValue } = require('../../../../graphql/services/contextHelper');

module.exports = (request) => {
  setContextValue(request, 'pageInfo', {
    title: 'Tags',
    description: 'Tags'
  });
  setContextValue(request, 'filtersFromUrl', buildFilterFromUrl(request));
};
