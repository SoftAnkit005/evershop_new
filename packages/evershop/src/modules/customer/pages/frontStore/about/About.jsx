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
      <section className='about-page'>
        <div className='container'>
          <div className='row align-items-start'>
            <div className='col-12 col-sm-12 col-md-12 col-lg-5 col-xl-5'>
              <div className='about-img d-none d-lg-block'>
                <img src='Assets/Images/about_img.png' alt='About' />
              </div>
              <div className='about-img mt-5'>
                <img src='Assets/Images/about.png' alt='About' />
              </div>
            </div>
            <div className='col-12 col-sm-12 col-md-12 col-lg-7 col-xl-7 px-4'>
              <div className='text-left'>
                <h3 className='products-subtitle-black text-uppercase my-5'>about Dr.BWC</h3>
                <p className='font-14 text-theme-grey'>Dr. BWC: Revolutionizing Relaxation with Automated Innovation</p>
                <p className='font-14 text-theme-grey mt-4'>In the realm of relaxation and wellness, one name stands out as a beacon of innovation and quality—Dr. BWC. Pioneering the manufacturing of customized fully automatic robotic zero gravity massage chairs, Dr. BWC has carved a niche for itself by blending cutting-edge technology with the age-old need for relaxation and comfort. Spanning across the vast expanse of India, our mission is to provide the best products and services, ensuring that every individual can experience unparalleled relaxation through automation.</p>
                <p className='font-14 text-theme-grey mt-4'>Our journey began with a simple yet profound vision: to transform the way people experience relaxation. In a world where stress and fatigue have become commonplace, Dr. BWC recognized the need for advanced solutions that not only alleviate physical strain but also promote overall well-being. Thus, we embarked on a path of relentless innovation, setting new standards in the wellness industry with our state-of-the-art massage chairs.</p>
                <p className='font-14 text-theme-grey mt-4'>What sets Dr. BWC apart is our unwavering commitment to customization. We understand that every individual has unique needs and preferences when it comes to relaxation. Our fully automatic robotic zero gravity massage chairs are designed with this in mind, offering a personalized experience that caters to your specific requirements. Whether you seek relief from chronic pain, a moment of tranquility after a long day, or simply a luxurious indulgence, our massage chairs are tailored to meet your needs.</p>
                
                <p className='font-14 text-theme-grey mt-4'>At the heart of our product line is the zero gravity feature, inspired by NASA’s space exploration technology. This innovative design elevates your legs above your heart, mimicking the posture astronauts adopt during space missions. This position not only reduces the strain on your spine and joints but also enhances blood circulation, allowing you to experience the ultimate in relaxation and comfort. Combined with our advanced robotic technology, our massage chairs deliver precise and effective massages that rejuvenate your body and mind.</p>
                <p className='font-14 text-theme-grey mt-4'>Dr. BWC’s commitment to excellence extends beyond our products. We pride ourselves on delivering exceptional customer service, ensuring that your experience with us is seamless and satisfying. Our team of experts is dedicated to guiding you through every step of your journey, from selecting the perfect massage chair to providing after-sales support. We believe that true relaxation comes from not only a superior product but also from knowing that you are in good hands.</p>
                <p className='font-14 text-theme-grey mt-4'>Our range of massage products is designed to cater to a diverse clientele, offering something for everyone. From compact models for those with limited space to luxurious chairs with an array of features, Dr. BWC ensures that you find the perfect match for your needs. Our products are crafted with the finest materials and incorporate the latest technological advancements, making us a trusted name in the wellness industry.</p>
                <p className='font-14 text-theme-grey mt-4'>As we continue to grow and innovate, our core mission remains the same: to provide relaxation with automation to everyone. We envision a future where every household in India can experience the benefits of our massage chairs, enhancing their quality of life and well-being. Dr. BWC is more than a brand; it is a promise of comfort, innovation, and excellence.</p>
                <p className='font-14 text-theme-grey mt-4'>Join us on this journey and discover the unparalleled joy of relaxation with Dr. BWC. Because when it comes to your well-being, you deserve nothing but the best.</p>
              </div>
            </div>
          </div>
        </div>
      </section>
      <section className='about-team py-5'>
        <div className='container'>
          <div className='team-title text-center'>
            <h3 className='products-subtitle-black text-uppercase my-5'>about out team</h3>
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
      <section className='testimonial mt-0 mb-5 about-slider pt-5'>
        <div className='container'>
          <div className='bg-transparent text-center'>
            <h3 className='products-subtitle-black text-uppercase mt-5'>Happy customers</h3>
            <p className='products-details-black'>Convallis ullamcorper aliquet ultrices orci cum vestibulum lobortis erat.</p>
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


