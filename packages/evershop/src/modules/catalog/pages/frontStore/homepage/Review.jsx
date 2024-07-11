/* eslint-disable react/jsx-props-no-spreading */

import React, { useEffect } from "react";
import "../../../../Styles/Styles.scss";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { useState } from "react";
// import { FaRegStar, FaStar } from "react-icons/fa6";

export default function Review() {
//   const [reviewData, setreviewData] = useState([]);

//   useEffect(() => {
//     async function fetchMyAPI() {
//       const result = await fetch("https://drbwc.com/api/getreviewdata", {
//         method: "GET",
//         headers: {
//           "Content-Type": "application/json",
//         },
//         redirect: "follow",
//       });
//       const data = await result.json();
//       setreviewData(data);
//     }

//     fetchMyAPI();
//   }, []);

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
            {/* {reviewData !== undefined && reviewData !== null ? (
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
            )} */}
            <div>
                <div className="card p-4 py-5 mx-3 justify-content-between" style={{ minHeight: "250px", height: "250px" }} >
                  <p className="fs-4 lh-lg review-card" data-toggle="tooltip" data-placement="bottom" title="I have purchased foot massager which is best in quality as well as geniune company dealing with products u appreciate." > I have purchased zero gravity massage chair & I have visited the company. all products are german engineered. </p>
                  <h3 className="fs-4 font-bold mt-2 text-capitalize">Aadit Patel</h3>
                </div>
            </div>
            <div>
                <div className="card p-4 py-5 mx-3 justify-content-between" style={{ minHeight: "250px", height: "250px" }} >
                  <p className="fs-4 lh-lg review-card" data-toggle="tooltip" data-placement="bottom" title="I have purchased foot massager which is best in quality as well as geniune company dealing with products u appreciate." > I have purchased foot massager which is best in quality as well as geniune company dealing with products u appreciate. </p>
                  <h3 className="fs-4 font-bold mt-2 text-capitalize">Salmon Ningeri</h3>
                </div>
            </div>
            <div>
                <div className="card p-4 py-5 mx-3 justify-content-between" style={{ minHeight: "250px", height: "250px" }} >
                  <p className="fs-4 lh-lg review-card" data-toggle="tooltip" data-placement="bottom" title="I have purchased foot massager which is best in quality as well as geniune company dealing with products u appreciate." > I have purchase massage chair very happy with product and service. Very good company. Genuine person. </p>
                  <h3 className="fs-4 font-bold mt-2 text-capitalize">Vijay Accountant</h3>
                </div>
            </div>
            <div>
                <div className="card p-4 py-5 mx-3 justify-content-between" style={{ minHeight: "250px", height: "250px" }} >
                  <p className="fs-4 lh-lg review-card" data-toggle="tooltip" data-placement="bottom" title="I have purchased foot massager which is best in quality as well as geniune company dealing with products u appreciate." > Folding Massage Bed, Very Good product and I am happy and satisfied for sales and services. </p>
                  <h3 className="fs-4 font-bold mt-2 text-capitalize">Vandana Rawal</h3>
                </div>
            </div>
          </Slider>
        </div>
        {/* <a className="btn-light-brown m-auto" href="#">
            <span className="wd-btn-text" data-elementor-setting-key="text">Leave a review</span>
        </a> */}
      </div>
    </section>
  );
}
export const layout = {
  areaId: "content",
  sortOrder: 13,
};
