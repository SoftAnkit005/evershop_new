
import React from 'react';
import "../../../../Styles/Styles.scss";
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import './FeaturedUserSlider.scss'
import { FaCirclePlay, FaYoutube} from 'react-icons/fa6';


export default function FeaturedUserSlider() {

    const settings = {
        infinite: true,
        arrows: false,
        slidesToShow: 3,
        slidesToScroll: 1,
        autoplay: true,
        speed: 2500,
        autoplaySpeed: 2500,
        cssEase: "linear",
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
                    slidesToShow: 3
                }
            }
        ]
    };

    return (
        <section className='accreditation bg-transparent'>
            <div className='container'>
                <div className='text-center'>
                    <h3 className='products-subtitle-black text-uppercase mb-5'>Product Details</h3>
                </div>
                <div className='accreditation-item user-slider'>
                    <Slider {...settings}>
                        <a href="https://www.youtube.com/watch?v=LqVvZt2b9LI" className='product-image position-relative shadow-lg' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/5d_automatic_massage_chair.jpg' alt='5d_automatic_massage_chair' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=I_XQpm1dycs" className='product-image position-relative' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/4d_zero_gravity_massage_chair.jpg' alt='4d_zero_gravity_massage_chair' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=3P0dPjB7YFA" className='product-image position-relative' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/4d_comfy_massage_chair.webp' alt='4d_comfy_massage_chair' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=a4xxyFhgw6M" className='product-image position-relative' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/foot_massager.png' alt='foot_massager' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=-sH21FadQKQ" className='product-image position-relative' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/space_cpsule_massage_chair.jpg' alt='space_cpsule_massage_chair' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=-fuQvzGJ6ro" className='product-image position-relative' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/fully_automatic_robotic_zero_gravity.png' alt='fully_automatic_robotic_zero_gravity' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=ILHvXl10bRk" className='product-image position-relative' target='_blank'>
                            <img className='member-img' src='Assets/Images/userslider-thumbnails/relaxo_advanced_ai_techonology.jpg' alt='relaxo_advanced_ai_techonology' />
                            <FaYoutube className="play-icon"/>
                        </a>
                        <a href="https://www.youtube.com/watch?v=yGHMgdC4a0M" className='product-image position-relative' target='_blank'>
                            <img className='member-img p-5' src='Assets/Images/userslider-thumbnails/red_foot_massager.jpg' alt='red_foot_massager' />
                            <FaYoutube className="play-icon"/>
                        </a>
                    </Slider>
                </div>
            </div>
        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 15
};