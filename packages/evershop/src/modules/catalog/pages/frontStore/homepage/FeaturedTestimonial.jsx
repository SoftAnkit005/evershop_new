/* eslint-disable react/jsx-props-no-spreading */

import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../../../../Styles/Styles.scss";
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

export default function FeaturedTestimonial() {

    const settings = {
        infinite: true,
        centerPadding: "60px",
        slidesToShow: 1,
        slidesToScroll: 1,
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
        <section className='testimonial client-review'>
            <div className='container'>
                <div className='text-center'>
                    <h2 className='products-title-black'>Testimonial</h2>
                    <h3 className='products-subtitle-black'>Customer Review</h3>
                    <p className='products-details-black'>They have already used our services.</p>
                </div>

                <Slider {...settings}>
                    <div className='testimonial-slide'>
                        <img src='Assets/Images/client_one.png' alt='Testimonial Post' className='client-img' />
                        <div className='card'>
                            <div className='card-header'>
                                <div className='card-name'>
                                    <h3 className='client-name'>Slmon ningeri</h3>
                                    {/* <p className='products-details-white text-start m-0 p-0'>Lead Assurance Developer at LionEnergy</p> */}
                                </div>
                                {/* <div className='card-img w-auto'>
                                    <img src='Assets/Images/liqnenergy.png' alt='Card One' />
                                </div> */}
                            </div>
                            <div className='card-body'>
                                <p className='products-details-white text-start'>I have purchased foot massager which is best in quality as well as geniune company dealing with products u appreciate.</p>
                            </div>
                        </div>
                    </div>
                    <div className='testimonial-slide'>
                        <img src='Assets/Images/client_two.png' alt='Testimonial Post' className='client-img' />
                        <div className='card'>
                            <div className='card-header'>
                                <div className='card-name'>
                                    <h3 className='client-name'>Vijay Accountant</h3>
                                    {/* <p className='products-details-white text-start m-0 p-0'>Lead Assurance Developer at LionEnergy</p> */}
                                </div>
                                {/* <div className='card-img w-auto'>
                                    <img src='Assets/Images/liqnenergy.png' alt='Card One' />
                                </div> */}
                            </div>
                            <div className='card-body'>
                                <p className='products-details-white text-start'>I have purchase massage chair very happy with product and service. Very good company. Genuine person.</p>
                            </div>
                        </div>
                    </div>
                    <div className='testimonial-slide'>
                        <img src='Assets/Images/client_three.png' alt='Testimonial Post' className='client-img' />
                        <div className='card'>
                            <div className='card-header'>
                                <div className='card-name'>
                                    <h3 className='client-name'>Vandana Rawal</h3>
                                    {/* <p className='products-details-white text-start m-0 p-0'>Lead Assurance Developer at LionEnergy</p> */}
                                </div>
                                {/* <div className='card-img w-auto'>
                                    <img src='Assets/Images/liqnenergy.png' alt='Card One' />
                                </div> */}
                            </div>
                            <div className='card-body'>
                                <p className='products-details-white text-start'>Folding Massage Bed, Very Good product and I am happy and satisfied for sales and services.</p>
                            </div>
                        </div>
                    </div>
                </Slider>
            </div>
        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 13
};