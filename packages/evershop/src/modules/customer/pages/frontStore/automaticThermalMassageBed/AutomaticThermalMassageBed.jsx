import React from 'react'
import "../../../../Styles/Styles.scss";
import "./AutomaticThermalMassageBed.scss";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from 'react-slick';

export default function About() {

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
      <section className='automatic-thermal-massage-bed-page'>
        <div className='product-banner'>
          <div className='container'>
            <div className='row align-items-center'>
              <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                <div className='products-img'>
                  <img src="" alt="" className='w-100' />
                </div>
              </div>
              <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                <div className='products-info'>
                  <h2 className='products-title-white fs-1'>Advanced Master V4 Gold By Dr.BWC</h2>
                  <h3 className='products-subtitle-white'>AUTOMATIC THERMAL MASSAGE BED</h3>
                  <p className='font-16 text-white'>Automatic Jade Stone Thermal Heating Bed.</p>
                  <div className='mt-3'>
                    <a href="" className='btn-white'>BUY NOW</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className='about-product'>
          <div className='container'>
            <div className='row align-items-center'>
              <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                <div className='products-info'>
                  {/* <h1 className='products-title-black'>Auto Wellness Program</h1> */}
                  <h3 className='products-subtitle-white text-dark fs-1 text-uppercase font-semibold'>How is Dr.BWC's Advanced Master V4 Bed?​</h3>
                  <p className='font-16'>Spine is the central organ of the human body that protects the spinal cord, which connects our nerves. Dr. BWC Master V4 is a thermal device that provides intensive heat and pressure stimulation to the spine and gives a personalised thermal massage experience.</p>
                </div>
              </div>
              <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                <div className='products-img'>
                  <video autoPlay loop muted className="w-100 h-100 object-fit-cover">
                    <source src='Assets/videos/prod1.mp4' type="video/mp4" />
                    Your browser does not support the video tag.
                  </video>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className='product-experience'>
          <div className='container'>
            <div className='products-info'>
              <h3 className='products-subtitle-white text-uppercase w-75 text-center m-auto position-relative'>Let’s experience Dr. BWC Master V4 Spine Thermal Device</h3>
              <p className='fs-2 text-white text-center my-3'>For 40 minutes a day. It works like a charm for:</p>
            </div>
            <div className='row'>
              <div className='col-6 col-lg-3 position-relative'>
                <img src='Assets/Images/office_employee.jpg' alt='office employee' />
                <h6 className="position-absolute text-white text-center w-100 py-3 bottom-0">Office Employee</h6>
              </div>
              <div className='col-6 col-lg-3 position-relative'>
                <img src='Assets/Images/home_maker.jpg' alt='home maker' />
                <h6 className="position-absolute text-white text-center w-100 py-3 bottom-0">Office Employee</h6>
              </div>
              <div className='col-6 col-lg-3 position-relative'>
                <img src='Assets/Images/student.jpg' alt='student' />
                <h6 className="position-absolute text-white text-center w-100 py-3 bottom-0">Office Employee</h6>
              </div>
              <div className='col-6 col-lg-3 position-relative'>
                <img src='Assets/Images/parents.jpg' alt='parents' />
                <h6 className="position-absolute text-white text-center w-100 py-3 bottom-0">Office Employee</h6>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  )
}


export const layout = {
  areaId: 'content',
  sortOrder: 10
};


