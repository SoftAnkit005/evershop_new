const { OK, INTERNAL_SERVER_ERROR } = require('@evershop/evershop/src/lib/util/httpStatus');
// Adjust the path as per your project structure

module.exports = async (request, response, delegate) => {
  try {
    // Log the start of the request
    console.log('Processing request...');

    // Call the getSearch function
    const search = await delegate.createSearch;

    // Log the search result
    console.log('Search result:', search);

    // Check if the headers have already been sent
    if (response.headersSent) {
      console.warn('Headers already sent. Skipping response.');
      return;
    }

    // Send the response
    response.status(OK).json({
      data: {
        ...search
      }
    });
  } catch (error) {
    // Log the error
    console.error('Error occurred:', error);

    // Check if the headers have already been sent
    if (response.headersSent) {
      console.warn('Headers already sent. Skipping error response.');
      return;
    }

    // Send the error response
    response.status(INTERNAL_SERVER_ERROR).json({
      error: 'Internal Server Error'
    });
  }
};









// const { OK, INTERNAL_SERVER_ERROR } = require('@evershop/evershop/src/lib/util/httpStatus');
// // Adjust the path as per your project structure

// module.exports = async (request, response, delegate) => {
//   try {
//     // Log the start of the request
//     console.log('Processing request...');

//     // Call the getSearch function
//     const search = await delegate.createSearch;

//     // Log the search result
//     console.log('Search result:', search);

//     // Send the response
//     return response.status(OK).json({
//       data: {
//         ...search
//       }
//     });
//   } catch (error) {
//     // Log the error
//     console.error('Error occurred:', error);

//     // Send the error response
//     return response.status(INTERNAL_SERVER_ERROR).json({
//       error: 'Internal Server Error'
//     });
//   }
// };




// const { OK, INTERNAL_SERVER_ERROR } = require('@evershop/evershop/src/lib/util/httpStatus');
// // Adjust the path as per your project structure

// module.exports = async (request, response, delegate) => {
//   try {
//      // Call the getSearch function
//     const search = await delegate.createSearch;
   
//     response.status(OK).json({
//       data: {
//         ...search
//       }
//     });
//   } catch (error) {
//     response.status(INTERNAL_SERVER_ERROR).json({
//       error: 'Internal Server Error'
//     });
//   }
// };


