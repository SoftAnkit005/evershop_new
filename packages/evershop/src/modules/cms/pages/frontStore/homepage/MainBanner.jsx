import PropTypes from 'prop-types';
import React, { useState } from 'react';
import '@components/frontStore/catalog/product/list/item/Thumbnail.scss';

function MainBanner({ images }) {
  const [activeIndex, setActiveIndex] = useState(0);

  const handleIndicatorClick = (index) => {
    setActiveIndex(index);
  };

  return (
    <div className="carousel-slider">
      <div className="carousel-inner">
        {images.map((image, index) => (
          <div key={index} className={`carousel-item ${index === activeIndex ? 'active' : ''}`}>
            <img src={image.imageUrl} alt={image.alt} />
          </div>
        ))}
      </div>
      <div className="carousel-indicators">
        {images.map((_, index) => (
          <button
            key={index}
            type="button"
            data-bs-target="#carouselExampleCaptions"
            data-bs-slide-to={index}
            className={index === activeIndex ? 'active' : ''}
            aria-current={index === activeIndex ? 'true' : 'false'}
            aria-label={`Slide ${index + 1}`}
            onClick={() => handleIndicatorClick(index)}
          ></button>
        ))}
      </div>
    </div>
  );
}

MainBanner.propTypes = {
  images: PropTypes.arrayOf(
    PropTypes.shape({
      imageUrl: PropTypes.string.isRequired,
      alt: PropTypes.string.isRequired,
    })
  ).isRequired,
};

export { MainBanner };
