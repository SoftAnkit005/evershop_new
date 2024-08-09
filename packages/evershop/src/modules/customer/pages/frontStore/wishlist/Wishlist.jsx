/* eslint-disable jsx-a11y/label-has-associated-control */
/* eslint-disable jsx-a11y/iframe-has-title */
import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import "../../../../Styles/Styles.scss";
import ProductList from '@components/frontStore/catalog/product/list/List';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

export default function Wishlist({account, products: { items }}) {
  const filteredWishlist = items.filter(({productId}) => account.wishlistedProducts.items.includes(productId.toString()));
    
    return (
      <div>
          <ProductList products={filteredWishlist} countPerRow={4} listType = "wishlist" />
          {/* <div className="product-count font-16 text-end">
              {_('${count} products', { count: items.length })}
          </div> */}
      </div>
    );
}

export const layout = {
    areaId: 'content',
    sortOrder: 10
};

Wishlist.propTypes = {
  account: PropTypes.shape({
    fullName: PropTypes.string.isRequired,
    email: PropTypes.string.isRequired,
    wishlistedProducts: PropTypes.shape({
      items: PropTypes.arrayOf(PropTypes.string).isRequired
    }).isRequired
  }).isRequired,

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
};


export const query = `
  query Query {
    account: currentCustomer {
      fullName
      email
      wishlistedProducts
    }
    products {
      items {
        ...Product
      }
    }
  }
`;

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
  }
`;