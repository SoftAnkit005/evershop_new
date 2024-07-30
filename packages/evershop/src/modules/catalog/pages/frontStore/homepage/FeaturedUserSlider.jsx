
import React from 'react';
import "../../../../Styles/Styles.scss";
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import './FeaturedUserSlider.scss'


export default function FeaturedUserSlider() {

    const settings = {
        infinite: true,
        arrows: false,
        slidesToShow: 5,
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
                    <h3 className='products-subtitle-black text-uppercase mb-5'>User Slider</h3>
                </div>
                <div className='accreditation-item user-slider'>
                    <Slider {...settings}>
                        <a href="https://youtu.be/LqVvZt2b9LI" className='accreditation-image position-relative' target='_blank'>
                            <video autoPlay loop muted className="w-full h-full object-fit-cover">
                                    <source src='Assets/videos/prod1.mp4' type="video/mp4" />
                                    Your browser does not support the video tag.
                            </video>
                        </a>
                        <a href="https://youtu.be/LqVvZt2b9LI" className='accreditation-image position-relative' target='_blank'>
                            <video autoPlay loop muted className="w-full h-full object-fit-cover">
                                    <source src='Assets/videos/prod2.mp4' type="video/mp4" />
                                    Your browser does not support the video tag.
                            </video>
                        </a>
                        <a href="https://youtu.be/LqVvZt2b9LI" className='accreditation-image position-relative' target='_blank'>
                            <video autoPlay loop muted className="w-full h-full object-fit-cover">
                                    <source src='Assets/videos/prod3.mp4' type="video/mp4" />
                                    Your browser does not support the video tag.
                            </video>
                        </a>
                        <a href="https://youtu.be/LqVvZt2b9LI" className='accreditation-image position-relative' target='_blank'>
                            <video autoPlay loop muted className="w-full h-full object-fit-cover">
                                    <source src='Assets/videos/prod4.mp4' type="video/mp4" />
                                    Your browser does not support the video tag.
                            </video>
                        </a>
                        <a href="https://youtu.be/LqVvZt2b9LI" className='accreditation-image position-relative' target='_blank'>
                            <video autoPlay loop muted className="w-full h-full object-fit-cover">
                                    <source src='Assets/videos/prod1.mp4' type="video/mp4" />
                                    Your browser does not support the video tag.
                            </video>
                        </a>
                        <a href="https://youtu.be/LqVvZt2b9LI" className='accreditation-image position-relative' target='_blank'>
                            <video autoPlay loop muted className="w-full h-full object-fit-cover">
                                    <source src='Assets/videos/prod2.mp4' type="video/mp4" />
                                    Your browser does not support the video tag.
                            </video>
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