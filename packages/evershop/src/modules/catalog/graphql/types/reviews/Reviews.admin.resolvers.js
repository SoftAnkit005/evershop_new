const { select } = require('@evershop/postgres-query-builder');
const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');

module.exports = {
  Review: {
    editUrl: (review) => buildUrl('reviewEdit', { id: review.id }),
    updateApi: (review) => buildUrl('updateReview', { id: review.id }),
    deleteApi: (review) => buildUrl('deleteReview', { id: review.id }),
    addProductUrl: (review) =>
      buildUrl('addreview', { id: review.id })
  },
  Product: {
    removeFromReviewUrl: async ( _, { pool }) => {
      
        const review = await select()
          .from('reviews')
          .where('id', '!=', '')
          .load(pool);
        return buildUrl('removeFromReviewUrl', {
          id: review.id,
          name: review.name,
          review: review.review
        });
      }
    }
  };

