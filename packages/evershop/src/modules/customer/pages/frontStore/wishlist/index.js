const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');
const {
  translate
} = require('@evershop/evershop/src/lib/locale/translate/translate');
const {
  setContextValue
} = require('../../../../graphql/services/contextHelper');

module.exports = (request, response, delegate, next) => {
  setContextValue(request, 'pageInfo', {
    title: translate('Wishlist'),
    description: translate('Wishlist')
  });
  next();
  // Check if the user is logged in
  // if (request.isCustomerLoggedIn()) {
  // } else {
  //   // Redirect to homepage
  //   // response.redirect(buildUrl('homepage'));
  // }
};
