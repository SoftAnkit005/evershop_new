const {
  OPERATION_MAP
} = require('@evershop/evershop/src/lib/util/filterOperationMapp');
const { getValueSync } = require('@evershop/evershop/src/lib/util/registry');

module.exports = async function registerDefaultCollectionCollectionFilters() {
  // List of default supported filters
  const defaultFilters = [
    {
      key: 'name',
      operation: ['like'],
      callback: (query, operation, value, currentFilters) => {
        query.andWhere(
          'tags.name',
          OPERATION_MAP[operation],
          `%${value}%`
        );
        currentFilters.push({
          key: 'name',
          operation,
          value
        });
      }
    },
    {
      key: 'product_id',
      operation: ['like', 'eq'],
      callback: (query, operation, value, currentFilters) => {
        query.andWhere(
          'tags.product_id',
          OPERATION_MAP[operation],
          `%${value}%`
        );
        currentFilters.push({
          key: 'product_id',
          operation,
          value
        });
      }
    },
    {
      key: 'ob',
      operation: ['eq'],
      callback: (query, operation, value, currentFilters) => {
        const collectionSortBy = getValueSync('tagCollectionSortBy', {
          name: (query) => query.orderBy('tags.name'),
          code: (query) => query.orderBy('tags.product_id')
        });

        if (collectionSortBy[value]) {
          collectionSortBy[value](query, operation);
          currentFilters.push({
            key: 'ob',
            operation,
            value
          });
        } else {
          query.orderBy('tags.id', 'DESC');
        }
      }
    }
  ];

  return defaultFilters;
};
