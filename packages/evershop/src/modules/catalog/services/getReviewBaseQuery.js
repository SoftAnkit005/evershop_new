const { select } = require('@evershop/postgres-query-builder');

async function getReviewBaseQuery() {
    const query = select().from('reviews');  
   
    return query;

}

module.exports = { getReviewBaseQuery }; // Export as an object with the function
