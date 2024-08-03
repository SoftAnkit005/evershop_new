import PropTypes from 'prop-types';
import React, { useEffect } from 'react';
import ProductList from '@components/frontStore/catalog/product/list/List';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export default function Products({
  products: {
    products: { items }
  },
  allTags = []
}) {

  return (
    <div>
      <ProductList products={items} countPerRow={3} tags={allTags} />
      {/* <div className="product-count font-16 text-end">
        {_('${count} products', { count: items.length })}
      </div> */}
    </div>
  );
}

Products.propTypes = {
  products: PropTypes.shape({
    products: PropTypes.shape({
      items: PropTypes.arrayOf(
        PropTypes.shape({
          name: PropTypes.string,
          productId: PropTypes.number,
          url: PropTypes.string,
          price: PropTypes.shape({
            regular: PropTypes.shape({
              value: PropTypes.float,
              text: PropTypes.string
            }),
            special: PropTypes.shape({
              value: PropTypes.float,
              text: PropTypes.string
            })
          }),
          inventory: PropTypes.shape({
            isInStock: PropTypes.bool.isRequired
          }).isRequired,
          image: PropTypes.shape({
            alt: PropTypes.string,
            listing: PropTypes.string
          })
        })
      )
    })
  })
};

Products.defaultProps = {
  products: {
    products: {
      items: []
    }
  }
};

export const layout = {
  areaId: 'rightColumn',
  sortOrder: 25
};

export const query = `
  query Query($filters: [FilterInput]) {
    products: category(id: getContextValue('categoryId')) {
      products(filters: $filters) {
        items {
          ...Product
        }
      }
    }
    allTags {
      items {
        id
        name
        productId
      }
    }
  }`;

export const fragments = `
  fragment Product on Product {
    productId
    name
    sku
    price {
      regular {
        value
        text
      }
      special {
        value
        text
      }
    }
    inventory {
      isInStock
    }
    image {
      alt
      url: listing
    }
    url
    description
    companydetails
  }
`;

export const variables = `
{
  filters: getContextValue('filtersFromUrl')
}`;
