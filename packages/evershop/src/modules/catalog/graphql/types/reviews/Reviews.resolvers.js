  const { select } = require('@evershop/postgres-query-builder');
  const { camelCase } = require('@evershop/evershop/src/lib/util/camelCase');

  const {
    getReviewBaseQuery
  } = require('../../../services/getReviewBaseQuery');
  const { ReviewCollection } = require('../../../services/ReviewCollection');

  module.exports = {
    Query: {
      review: async (_, { id }, { pool }) => {
        const query = select().from('reviews');
        query.where('id', '=', id);
        const result = await query.load(pool);
        return result ? camelCase(result) : null;
      },
      reviews: async (_, { filters = [] }, { user }) => {
        const query = await getReviewBaseQuery();
      
        const root = new ReviewCollection(query);
        await root.init(filters, !!user);
        return root;
      }
    },
    Product: {
      review: async (_, { pool }) => {
        
          const reviewQuery = await getReviewBaseQuery();
          reviewQuery.where('id', '!=', '');
          const review = await reviewQuery.load(pool);
          return camelCase(review);
        
      }
    }
  };
