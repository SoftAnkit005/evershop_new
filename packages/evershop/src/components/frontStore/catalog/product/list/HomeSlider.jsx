import PropTypes from 'prop-types';
import React from 'react';
import { MainBanner } from '@default-theme/cms/frontStore/homepage/MainBanner';

export default function HomeSlider({ products = [] }) {
  if (products.length === 0) {
    return (
      <div className="product-list">
        <div className="text-center">There is no product to display</div>
      </div>
    );
  }

  const images = products.map(p => ({
    imageUrl: p.image.url,
    alt: p.name
  }));


  return (
    <div className="carousel-slider">
      <MainBanner images={images} />
    </div>
  );
}

HomeSlider.propTypes = {
  products: PropTypes.arrayOf(
    PropTypes.shape({
      name: PropTypes.string.isRequired,
      image: PropTypes.shape({
        url: PropTypes.string.isRequired
      }).isRequired
    }).isRequired
  ).isRequired
};
