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
          'reviews.name',
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
      key: 'view',
      operation: ['like', 'eq'],
      callback: (query, operation, value, currentFilters) => {
        query.andWhere(
          'reviews.view',
          OPERATION_MAP[operation],
          `%${value}%`
        );
        currentFilters.push({
          key: 'view',
          operation,
          value
        });
      }
    },
    {
      key: 'ob',
      operation: ['eq'],
      callback: (query, operation, value, currentFilters) => {
        const collectionSortBy = getValueSync('reviewCollectionSortBy', {
          name: (query) => query.orderBy('reviews.name'),
          code: (query) => query.orderBy('reviews.review')
        });

        if (collectionSortBy[value]) {
          collectionSortBy[value](query, operation);
          currentFilters.push({
            key: 'ob',
            operation,
            value
          });
        } else {
          query.orderBy('reviews.id', 'DESC');
        }
      }
    }
  ];

  return defaultFilters;
};
