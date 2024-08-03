const { select, value } = require('@evershop/postgres-query-builder');
const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');
const {
  getCouponBaseQuery
} = require('../../../services/getCouponBaseQuery');  
const { CouponCollection } = require('../../../services/CouponCollection');

module.exports = {
  Query: {
    coupon: async (_, { id }, { pool }) => {
      const query = select().from('coupon');
      query.where('coupon_id', '=', id);
      const result = await query.load(pool);
      return result ? camelCase(result) : null;
    },
    coupons: async (_, { filters = [] }, { user }) => {
      const query = await getCouponBaseQuery();
          
      const root = new CouponCollection(query);
      // await root.init(filters, !!user);
      return root;
    }
  }
};
