import HomeSlider from '@components/frontStore/catalog/product/list/HomeSlider';
import PropTypes from 'prop-types';
import React from 'react';

export default function FeaturedSlider({ collection }) {
  if (!collection) {
    return null;
  }

  return (

    <div className="">
      <div className="products">
        <h3 className="mt-3 mb-3 text-center uppercase h5 tracking-widest d-none">
          {collection.name}
        </h3>

        <HomeSlider products={collection.products.items} countPerRow={4} />
      </div>
    </div>
  );
}

FeaturedSlider.propTypes = {
  collection: PropTypes.shape({
    collectionId: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    products: PropTypes.shape({
      items: PropTypes.arrayOf(
        PropTypes.shape({
          productId: PropTypes.number.isRequired,
          sku: PropTypes.string.isRequired,
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
  areaId: 'content',
  sortOrder: 5
};

export const query = `
  query query {
    collection (code: "homepageslider") {
      collectionId
      name
      products (filters: [{key: "limit", operation: eq, value: "4"}]) {
        items {
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
            url: origin
          }
          url
        }
      }
    }
  }
`;
