
import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../../../../Styles/Styles.scss";
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";


export default function FeaturedAccreditation() {

    const settings = {
        infinite: true,
        centerPadding: "60px",
        slidesToShow: 5,
        slidesToScroll: 1,
        arrows: false,
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
                breakpoint: 992,
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
        <section className='accreditation'>
            <div className='container'>
                <div className='text-center'>
                    <h3 className='products-subtitle-black text-uppercase mb-5'>Our Accreditation</h3>
                    {/* <p className='products-details-black'>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p> */}
                </div>
                <div className='accreditation-item'>

                    <Slider {...settings}>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_one.jpg' alt='Accreditation One' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_two.jpg' alt='Accreditation Two' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_three.jpg' alt='Accreditation Three' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_four.jpg' alt='Accreditation Four' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_five.jpg' alt='Accreditation Five' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_six.jpg' alt='Accreditation six' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_seven.jpg' alt='Accreditation seven' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_eight.jpg' alt='Accreditation eight' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_nine.jpg' alt='Accreditation nine' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_ten.jpg' alt='Accreditation ten' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_eleven.jpg' alt='Accreditation eleven' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_twelve.jpg' alt='Accreditation twelve' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_thirteen.jpg' alt='Accreditation thirteen' />
                        </div>
                        <div className='accreditation-image'>
                            <img src='Assets/Images/accreditation_fourteen.jpg' alt='Accreditation fourteen' />
                        </div>
                    </Slider>
                </div>
            </div>
        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 16
};