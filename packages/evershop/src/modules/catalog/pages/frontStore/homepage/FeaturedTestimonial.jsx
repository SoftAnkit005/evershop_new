/* eslint-disable react/jsx-props-no-spreading */

import React from 'react';
import "../../../../Styles/Styles.scss";
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { FaRegStar, FaStar } from "react-icons/fa6";


export default function FeaturedTestimonial() {

    const settings = {
        infinite: true,
        centerPadding: "60px",
        slidesToShow: 4,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 2000,
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
                    slidesToShow: 2
                }
            },
        ]
    };



    return (
        <section className='testimonial bg-theme-gray client-review'>
            <div className='container'>
                <div className='text-center'>
                    <h2 className='products-title-black'>Testimonial</h2>
                    <h3 className='products-subtitle-black'>Customer Review</h3>
                    <p className='products-details-black'>They have already used our services.</p>
                </div>

                <div className="slider-container">
                    <Slider {...settings}>
                        <div>
                            <div className='card p-4 py-5 mx-3'>
                                <div className='card-body text-center'>
                                    <p className='fs-4 lh-lg'>“I've been using this web hosting service for over a year and I'm really impressed with the uptime and support. The website has never gone down and the customer service is always quick to help with any issues I have. Highly recommend!”</p>
                                    <div className='d-flex justify-content-center'>
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaRegStar className='rating-star' />
                                    </div>
                                    <img src='Assets/Images/client_one.png' alt='Testimonial Post' className='client-img' height={50} />
                                    <h3 className='fs-4 font-bold mt-2'>Slmon ningeri</h3>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div className='card p-4 py-5 mx-3'>
                                <div className='card-body text-center'>
                                    <p className='fs-4 lh-lg'>“I've been using this web hosting service for over a year and I'm really impressed with the uptime and support. The website has never gone down and the customer service is always quick to help with any issues I have. Highly recommend!”</p>
                                    <div className='d-flex justify-content-center'>
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaRegStar className='rating-star' />
                                    </div>
                                    <img src='Assets/Images/client_two.png' alt='Testimonial Post' className='client-img' height={50} />
                                    <h3 className='fs-4 font-bold mt-2'>Slmon ningeri</h3>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div className='card p-4 py-5 mx-3'>
                                <div className='card-body text-center'>
                                    <p className='fs-4 lh-lg'>“I've been using this web hosting service for over a year and I'm really impressed with the uptime and support. The website has never gone down and the customer service is always quick to help with any issues I have. Highly recommend!”</p>
                                    <div className='d-flex justify-content-center'>
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaRegStar className='rating-star' />
                                    </div>
                                    <img src='Assets/Images/client_three.png' alt='Testimonial Post' className='client-img' height={50} />
                                    <h3 className='fs-4 font-bold mt-2'>Slmon ningeri</h3>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div className='card p-4 py-5 mx-3'>
                                <div className='card-body text-center'>
                                    <p className='fs-4 lh-lg'>“I've been using this web hosting service for over a year and I'm really impressed with the uptime and support. The website has never gone down and the customer service is always quick to help with any issues I have. Highly recommend!”</p>
                                    <div className='d-flex justify-content-center'>
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaStar className='rating-star' />
                                        <FaRegStar className='rating-star' />
                                    </div>
                                    <img src='Assets/Images/client_two.png' alt='Testimonial Post' className='client-img' height={50} />
                                    <h3 className='fs-4 font-bold mt-2'>Slmon ningeri</h3>
                                </div>
                            </div>
                        </div>
                    </Slider>
                </div>
            </div>

        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 13
};