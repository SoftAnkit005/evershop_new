/* eslint-disable react/jsx-props-no-spreading */
import React, { useEffect } from "react";
import "../../../../Styles/Styles.scss";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import PropTypes from "prop-types";
// import { FaRegStar, FaStar } from "react-icons/fa6";

export default function Review({ reviews }) {
  // console.log("review", reviews);
  const settings = {
    infinite: true,
    centerPadding: "60px",
    slidesToShow: 3,
    slidesToScroll: 1,
    autoplay: true,
    arrows: false,
    autoplaySpeed: 2000,
    responsive: [
      {
        breakpoint: 575,
        settings: {
          slidesToShow: 1,
        },
      },
      {
        breakpoint: 767,
        settings: {
          slidesToShow: 1,
        },
      },
      {
        breakpoint: 1199,
        settings: {
          slidesToShow: 2,
        },
      },
    ],
  };

  return (
    <section className="testimonial bg-theme-gray client-review text-center">
      <div className="container">
        <div className="text-center">
          <h2 className="products-title-black">Testimonial</h2>
          <h3 className="products-subtitle-black">Customer Review</h3>
          <p className="products-details-black">
            They have already used our services.
          </p>
        </div>

        <div className="slider-container">
          <Slider {...settings}>
            {reviews.items !== undefined && reviews.items !== null ? (
              reviews.items.map((item, index) => (
                <div key={index}>
                  <div className="card p-4 py-5 mx-3 justify-content-between" style={{ minHeight: "250px", height: "250px" }} >
                    <p className="fs-4 lh-lg review-card" data-toggle="tooltip" data-placement="bottom" title={item.view} > {" "} {item.view}{" "} </p>
                    <h3 className="fs-4 font-bold mt-2">{item.name}</h3>
                  </div>
                </div>
              ))
            ) : (
              <>
                <div>No Reviews</div>
              </>
            )}
          </Slider>
        </div>
      </div>
    </section>
  );
}
export const layout = {
  areaId: "content",
  sortOrder: 13,
};

Review.propTypes = {
  reviews: PropTypes.shape({
    items: PropTypes.arrayOf(
      PropTypes.shape({
        name: PropTypes.string.isRequired,
        view: PropTypes.string.isRequired,
      })
    ).isRequired,
  }).isRequired,
};

export const query = `
  query {
  reviews {
      items {
        name
        view
      }
  }
}`;
