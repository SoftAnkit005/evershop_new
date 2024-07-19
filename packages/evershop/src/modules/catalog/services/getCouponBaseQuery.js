const { select } = require('@evershop/postgres-query-builder');

async function getCouponBaseQuery() {
    const query = select().from('coupon');  
   
    return query;

}

module.exports = { getCouponBaseQuery }; // Export as an object with the function
