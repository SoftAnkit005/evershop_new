import React from 'react'
import "../../../../Styles/Styles.scss";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from 'react-slick';

export default function About() {

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
    <>
      <section className='about-page'>
        <div className='container'>
          <div className='row'>
            <div className='col-12 col-sm-12 col-md-12 col-lg-5 col-xl-5'>
              <div className='about-img'>
                <img src='Assets/Images/about.png' alt='About' />
              </div>
            </div>
            <div className='col-12 col-sm-12 col-md-12 col-lg-7 col-xl-7'>
              <div className='text-left'>
                <h3 className='font-30'>about Dr.BWC</h3>
                <p className='font-16 text-black fw-semibold'>Dr. BWC’s has recently launched its first mega segment- Health and Fitness with Relaxation. Led by the visionary leadership of Dr. Kaushal Bhanusali & Dr. Alpa Bhanusali, the company is moving ahead, with an objective to help people achieve better health, more relaxation and smarter personality.</p>
                <p className='font-16 text-black fw-semibold'>Our basket of services is customized for anybody who is facing challenges in life and is stuck up with any health concern of lack of proper decision making. We empower him or her to hope, move ahead in life in an informed way and enjoy life to the fullest.</p>
                <p className='font-16 text-black fw-semibold'>Dr. BWC’s goal is to convert the “i”llness to “We”llness for all .</p>
                <p className='font-16 text-black fw-semibold'>The focus is on Recovery, Rehabilitation and Relaxation by Innovative Smart Intelligent Robotic Automatic Massage Products.</p>
              </div>
            </div>
          </div>
        </div>
      </section>
      <section className='about-team'>
        <div className='container'>
          <div className='team-title'>
            <h3>about out team</h3>
          </div>
          <div className='row'>
            <div className='col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6'>
              <div className='card'>
                <div className='card-body'>
                  <div className='card-img'>
                    <img src='Assets/Images/ceo_kaushal.png' alt='CEO Kaushal' />
                  </div>
                </div>
                <div className='card-footer text-center'>
                  <div className='card-space'>
                    <h6 className='font-24'>Kaushal Bhanusali</h6>
                    <h5 className='font-16'>CEO / FOUNDER</h5>
                    <ul className='d-flex justify-content-center'>
                      <li>
                        <a href='https://www.facebook.com/DrBhanusaliwellnesscare'>
                          <img src='Assets/Images/about_facebook.svg' alt='Facebook' />
                        </a>
                      </li>
                      <li>
                        <a href='https://x.com/BhanusaliW'>
                          <img src='Assets/Images/about_twitter.svg' alt='Twitter' />
                        </a>
                      </li>
                      <li>
                        <a href='https://www.instagram.com/dr.bhanusaliwellnesscare/'>
                          <img src='Assets/Images/about_insta.svg' alt='Instagram' />
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <div className='col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6'>
              <div className='card'>
                <div className='card-body'>
                  <div className='card-img'>
                    <img src='Assets/Images/ceo_alpa.png' alt='CEO Alpa' />
                  </div>
                </div>
                <div className='card-footer text-center'>
                  <div className='card-space'>
                    <h6 className='font-24'>Alpa Bhanusali</h6>
                    <h5 className='font-16'>CEO / FOUNDER</h5>
                    <ul className='d-flex justify-content-center'>
                      <li>
                        <a href='https://www.facebook.com/DrBhanusaliwellnesscare'>
                          <img src='Assets/Images/about_facebook.svg' alt='Facebook' />
                        </a>
                      </li>
                      <li>
                        <a href='https://x.com/BhanusaliW'>
                          <img src='Assets/Images/about_twitter.svg' alt='Twitter' />
                        </a>
                      </li>
                      <li>
                        <a href='https://www.instagram.com/dr.bhanusaliwellnesscare/'>
                          <img src='Assets/Images/about_insta.svg' alt='Instagram' />
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>
      </section>
      <section className='testimonial mt-0 mb-5 about-slider'>
        <div className='container'>
          <div className='instagram-info bg-transparent'>
            <h3>Happy customers</h3>
            <p className='text-black fw-semibold'>Convallis ullamcorper aliquet ultrices orci cum vestibulum lobortis erat.</p>
          </div>
          <Slider {...settings}>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_one.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_two.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_three.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_four.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_one.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_two.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_three.png' alt='Instagram Post' className='w-100' />
            </div>
            <div className='insta-slide'>
              <img src='Assets/Images/happy_customer_four.png' alt='Instagram Post' className='w-100' />
            </div>
          </Slider>
        </div>
      </section>
      <div className='mt-5 pt-5' />
    </>
  )
}


export const layout = {
  areaId: 'content',
  sortOrder: 10
};


