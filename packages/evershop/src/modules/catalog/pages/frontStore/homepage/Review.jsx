/* eslint-disable react/jsx-props-no-spreading */

import React, { useEffect } from "react";
import "../../../../Styles/Styles.scss";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { useState } from "react";
import axios from "axios";
// import { FaRegStar, FaStar } from "react-icons/fa6";

export default function Review() {
  const [reviewData, setreviewData] = useState([]);

  useEffect(() => {
    const currentURL = window.location.href;
    const newURL = currentURL.replace(currentURL, '');
    const pathStartIndex = newURL.indexOf('/', 8);
    const newPath = newURL.substring(pathStartIndex);
    const finalURL = window.location.origin + newPath;

    const fetchMyAPI = async () => {
      try {
        const header = {
          headers: {"content-type": "application/json"}
        }
        const response = await axios.get(`${finalURL}/api/getreviewdata`, header);
        setreviewData(response.data);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    }
    fetchMyAPI();
  }, []);

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
            {reviewData !== undefined && reviewData !== null ? (
              reviewData.map((item) => (
                <div>
                  <div className="card p-4 py-5 mx-3 justify-content-between" style={{ minHeight: "250px", height: "250px" }} >
                    <p className="fs-4 lh-lg review-card" data-toggle="tooltip" data-placement="bottom" title={item.view} > {item.view} </p>
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
