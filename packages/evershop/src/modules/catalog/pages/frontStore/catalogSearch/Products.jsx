import PropTypes from 'prop-types';
import React from 'react';
import ProductList from '@components/frontStore/catalog/product/list/List';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export default function Products({ products: { items } }) {
  return (
    <div>
      <ProductList products={items} countPerRow={4} />
      <div className="product-count font-16 text-end">
        {_('${count} products', { count: items.length })}
      </div>
    </div>
  );
}

Products.propTypes = {
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
        image: PropTypes.shape({
          alt: PropTypes.string,
          listing: PropTypes.string
        })
      })
    )
  })
};

Products.defaultProps = {
  products: {
    items: []
  }
};

export const layout = {
  areaId: 'oneColumn',
  sortOrder: 25
};


export const query = `
  query Query($filtersFromUrl: [FilterInput]) {
    products(filters: $filtersFromUrl) {
      items {
        ...Product
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
    image {
      alt
      url: listing
    }
    inventory {
      isInStock
    }
    url
  }
`;

export const variables = `{
  filtersFromUrl: getContextValue("filtersFromUrl")
}`;
