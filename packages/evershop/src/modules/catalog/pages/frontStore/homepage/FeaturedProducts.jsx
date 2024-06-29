import HomeProductList from '@components/frontStore/catalog/product/list/HomeProdustList';
import PropTypes from 'prop-types';
import React from 'react';

export default function FeaturedProducts({ collection }) {
  if (!collection) {
    return null;
  }
  return (
    <div className="">
      <div className="products">
        <h3 className="fae-head">
          {collection.name}
        </h3>

        <HomeProductList products={collection.products.items} countPerRow={4} />
      </div>
    </div>
  );
}

FeaturedProducts.propTypes = {
  collection: PropTypes.shape({
    collectionId: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    products: PropTypes.shape({
      items: PropTypes.arrayOf(
        PropTypes.shape({
          productId: PropTypes.number.isRequired,
          sku: PropTypes.string.isRequired,
          companydetails: PropTypes.string.isRequired,
          name: PropTypes.string.isRequired,
          price: PropTypes.shape({
            regular: PropTypes.shape({
              value: PropTypes.number.isRequired,
              text: PropTypes.string.isRequired
            }).isRequired,
            special: PropTypes.shape({
              value: PropTypes.number.isRequired,
              text: PropTypes.string.isRequired
            }).isRequired
          }).isRequired,
          image: PropTypes.shape({
            alt: PropTypes.string.isRequired,
            url: PropTypes.string.isRequired
          }).isRequired,
          url: PropTypes.string.isRequired
        })
      ).isRequired
    }).isRequired
  }).isRequired
};

export const layout = {
  areaId: '',
  sortOrder: 11
};

export const query = `
  query query {
    collection (code: "homepage") {
      collectionId
      name
      products (filters: [{key: "limit", operation: eq, value: "4"}]) {
        items {
          productId
          name
          sku
          companydetails
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
            url: origin
          }
          url
        }
      }
    }
  }
`;
