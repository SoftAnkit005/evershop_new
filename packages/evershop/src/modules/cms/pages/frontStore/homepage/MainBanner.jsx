/* eslint-disable react/jsx-props-no-spreading */
import PropTypes from 'prop-types';
import React from 'react';
import '@components/frontStore/catalog/product/list/item/Thumbnail.scss';
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

function MainBanner({ images }) {
  const settings = {
    infinite: true,
    centerPadding: "60px",
    slidesToShow: 1,
    slidesToScroll: 1,
    speed: 500,
    fade: true,
    autoplay: true,
    autoplaySpeed: 3000,
    cssEase: 'linear',
    dots: true,
    customPaging: (i) => (
      <div className="custom-dot">
        {i + 1}
      </div>
    ),
    responsive: [
      {
        breakpoint: 575,
        settings: {
          slidesToShow: 1
        }
      },
      {
        breakpoint: 767,
        settings: {
          slidesToShow: 1
        }
      },
      {
        breakpoint: 1199,
        settings: {
          slidesToShow: 1
        }
      },
      {
        breakpoint: 1440,
        settings: {
          slidesToShow: 1
        }
      }
    ]
  };

  return (
    <Slider {...settings}>
      {images.map((image, index) => (
        <div key={index}>
          <img src={image.imageUrl} alt={image.alt} />
        </div>
      ))}
    </Slider>
  );
}

MainBanner.propTypes = {
  images: PropTypes.arrayOf(
    PropTypes.shape({
      imageUrl: PropTypes.string.isRequired,
      alt: PropTypes.string.isRequired
    })
  ).isRequired
};

export { MainBanner };
