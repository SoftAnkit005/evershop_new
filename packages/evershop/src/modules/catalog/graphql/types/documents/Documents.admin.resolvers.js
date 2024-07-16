const { select } = require('@evershop/postgres-query-builder');
const { buildUrl } = require('@evershop/evershop/src/lib/router/buildUrl');

module.exports = {
  Document: {
    editUrl: (document) => buildUrl('documentEdit', { id: document.id }),
    updateApi: (document) => buildUrl('updateDocument', { id: document.id }),
    deleteApi: (document) => buildUrl('deleteDocument', { id: document.id }),
    addProductUrl: (document) =>
      buildUrl('adddocument', { id: document.id })
  },
  Product: {
    removeFromDocumentUrl: async ( _, { pool }) => {
      
        const document = await select()
          .from('documents')
          .where('id', '!=', '')
          .load(pool);
        return buildUrl('removeFromDocumentUrl', {
          id: document.id,
          name: document.name,
          document: document.document
        });
      }
    }
  };

