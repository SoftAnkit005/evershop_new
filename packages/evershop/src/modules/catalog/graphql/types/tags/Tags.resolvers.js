const { select } = require("@evershop/postgres-query-builder");
const { camelCase } = require("@evershop/evershop/src/lib/util/camelCase");

const {
  getTagBaseQuery,
  getAllTagBaseQuery,
} = require("../../../services/getTagBaseQuery");
const { TagCollection } = require("../../../services/TagCollection");

module.exports = {
  Query: {
    tag: async (_, { pool }) => {
      const query = select().from("tags");
      query.where("id", "=", id);
      const result = await query.load(pool);
      return result ? camelCase(result) : null;
    },
    tags: async (_, { filters = [] }, { user }) => {
      const query = await getTagBaseQuery();
      const root = new TagCollection(query);
      await root.init(filters, !!user);
      return root;
    },
    allTags: async (_) => {
      const query = await getTagBaseQuery();
      const root = new TagCollection(query);
      return root;
    },
  },
  Product: {
    tag: async (_, { pool }) => {
        const tagyQuery = await getTagBaseQuery();
        tagyQuery.where("product_id", "=", product.id);
        const tag = await tagyQuery.load(pool);
        return camelCase(tag);
    },
  },
};
