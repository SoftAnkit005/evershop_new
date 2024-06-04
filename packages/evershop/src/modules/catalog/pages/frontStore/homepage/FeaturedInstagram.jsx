/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../../../../Styles/Styles.scss";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from 'react-slick';

export default function FeaturedInstagram() {

    const settings = {
        infinite: true,
        centerPadding: "60px",
        slidesToShow: 4,
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
                    slidesToShow: 2
                }
            },
            {
                breakpoint: 1199,
                settings: {
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 1440,
                settings: {
                    slidesToShow: 4
                }
            }
        ]
    };



    return (
        <section className='testimonial'>
            <div className='container'>
                {/* <div className='text-center'>
                    <h3 className='products-subtitle-black'>Instagram</h3>
                    <p className='products-details-black'>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                </div> */}
                <div className='instagram-info'>
                    <img src='Assets/Images/instagram_id.svg' alt='Instagram ID' />
                    <h3>INSTAGRAM</h3>
                    <h3 className='text-black'>@dr.bhanusaliwellnesscare</h3>
                    <p>Follow us for exciting offers & stay updated with our latest technology!</p>
                </div>
                <Slider {...settings}>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_one.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_two.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_three.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_four.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_five.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_six.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_seven.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_eight.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_nine.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_ten.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_eleven.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                    <div className='insta-slide'>
                        <img src='Assets/Images/insta_post_twelve.jpg' alt='Instagram Post' className='w-100' />
                    </div>
                </Slider>
            </div>
        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 15
};