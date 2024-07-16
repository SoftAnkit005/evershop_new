  const { select } = require('@evershop/postgres-query-builder');
  const { camelCase } = require('@evershop/evershop/src/lib/util/camelCase');

  const {
    getDocumentBaseQuery
  } = require('../../../services/getDocumentBaseQuery');
  const { DocumentCollection } = require('../../../services/DocumentCollection');

  module.exports = {
    Query: {
      document: async (_, { id }, { pool }) => {
        const query = select().from('documents');
        query.where('id', '=', id);
        const result = await query.load(pool);
        return result ? camelCase(result) : null;
      },
      documents: async (_, { filters = [] }, { user }) => {
        const query = await getDocumentBaseQuery();
      
        const root = new DocumentCollection(query);
        await root.init(filters, !!user);
        return root;
      }
    },
    Product: {
      document: async (_, { pool }) => {
        
          const documentQuery = await getDocumentBaseQuery();
          documentQuery.where('id', '!=', '');
          const document = await documentQuery.load(pool);
          return camelCase(document);
        
      }
    }
  };
