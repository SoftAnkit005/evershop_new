const { OK, INTERNAL_SERVER_ERROR } = require('@evershop/evershop/src/lib/util/httpStatus');
// Adjust the path as per your project structure

module.exports = async (request, response, delegate) => {
  try {
     // Call the getSearch function
    const search = await delegate.createSearch;
   
    response.status(OK).json({
      data: {
        ...search
      }
    });
  } catch (error) {
    response.status(INTERNAL_SERVER_ERROR).json({
      error: 'Internal Server Error'
    });
  }
};
