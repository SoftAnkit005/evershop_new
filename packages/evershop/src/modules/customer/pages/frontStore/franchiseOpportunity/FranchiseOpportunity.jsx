import React from 'react';
import './../../../../Styles/Styles.scss';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

export default function FranchiseOpportunity() {

  var settings = {
    dots: true,
    infinite: true,
    centerPadding: "60px",
    slidesToShow: 3, 
    slidesToScroll: 1,
    responsive: [           
        {
          breakpoint: 575,
          settings: {
            slidesToShow: 1,
          }
        },
        {
            breakpoint: 767,
            settings: {
                slidesToShow: 2,
            }
        },
        {
            breakpoint: 1199,
            settings: {
              slidesToShow: 2,
            }
        },
        {
            breakpoint: 1440,
            settings: {
              slidesToShow: 3,
            }
        },
    ]       
};


  return (
    <>
    <section className='franchise-slider'>
        <div className='container-fluid'>
            <div className='row align-items-center'>
                <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                    <div className='franchise-info'>
                        <h1 className='font-48 text-black'>become Dr BWC franchise owner</h1>
                        <div className='mt-5'>
                            <a href='/thermal-heating-bed' className='btn-brown'>View all products</a>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                    <div className='great-earning-img'>
                        <img src='Assets/Images/great_earning.png' alt='Gift Image' className='w-85'/>
                        <a href='#' className='youtube-btn'>
                            <img src='Assets/Images/youtube-button.svg' alt='Youtube Video'/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section className='gallery'>
        <div className='container'>
            <div className='row align-items-end'>
                <div className='col-12 col-sm-12 col-md-3 col-lg-3'>
                    <h3 className='font-36 text-white mb-5'>Gallery</h3>                
                </div>
                <div className='col-12 col-sm-12 col-md-9 col-lg-9'>
                    <Slider {...settings}>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_one.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_two.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_three.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_four.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_one.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_two.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_three.png' alt='Instagram Post' className='w-100' />
                        </div>
                        <div className='insta-slide'>
                            <img src='Assets/Images/insta_post_four.png' alt='Instagram Post' className='w-100' />
                        </div>
                    </Slider>
                </div>
            </div>
        </div>
    </section>

    <section className='about-bhanusali'>
        <div className='container'>
            <div className='row align-items-center'>
                <div className='col-12 col-sm-12 col-md-12 col-lg-5'>
                    <div className='about-img'>
                    <img src='Assets/Images/about_bwc.png' alt='Gift Image' className='w-100'/>
                    </div>
                </div>
                <div className='col-12 col-sm-12 col-md-12 col-lg-7'>
                    <div className='about-content text-start ms-5'>
                    <h3 className="font-30 pb-3">about Dr.BWC</h3>
                    <p className="products-details-black text-start text-body-tertiary">Dr. BWC’s has recently launched its first mega segment- Health and Fitness with Relaxation. Led by the visionary leadership of Dr. Kaushal Bhanusali & Dr. Alpa Bhanusali, the company is moving ahead, with an objective to help people achieve better health, more relaxation and smarter personality.</p>
                    <p className="products-details-black text-start text-body-tertiary">Our basket of services is customized for anybody who is facing challenges in life and is stuck up with any health concern of lack of proper decision making. We empower him or her to hope, move ahead in life in an informed way and enjoy life to the fullest.</p>
                    <p className="products-details-black text-start text-body-tertiary">Dr. BWC’s goal is to convert the  “i”llness to “We”llness for all .
                    The focus is on Recovery, Rehabilitation and Relaxation by Innovative Smart Intelligent Robotic Automatic Massage Products.</p>
                    </div>
                </div>          
            </div>
        </div>
    </section>



    <section className='ralax-zone'>
        <div className='container'>
            <div className='row align-items-center'>
                <div className='col-12 col-sm-12 col-md-12 col-lg-7'>
                    <div className='relaxation-content text-start ms-5'>
                        <h3 className="font-36 pb-3 text-white">Why choose Dr. BWC's Relax Zone</h3>
                        <p className='font-16 text-white'>To be a professional Engineer or doctor it takes lacs or some time cores of rupees and years of education.</p>
                        <p className='font-16 text-white'>4 years of engineering can get you a yearly package of 4 to 5 lacs; and if you manage to get an MBA after that, a package of 10 to 25 lacs can be offered to you.</p>
                        <p className='font-16 text-white'><b>Where as</b></p>
                        <p className='font-16 text-white'>5 years of MBBS is only the beginning. After this you may get a job and start your practice, but only an MBBS degree is not of much value in the present market. Hence, you need to do a specialization to earn 5 to 6 lacs a year.</p>
                        <p className='font-16 text-white'>Dr. BWC’S gives you an opportunity get respected status as well as handsome earnings in just a small investment and minimal training.</p>
                        <ul className='m-0 ps-2'>
                            <li className="font-16 text-white">100% Return guaranteed </li>
                            <li className="font-16 text-white">Monthly income</li>
                            <li className="font-16 text-white">Limited Risks & Liability</li>
                            <li className="font-16 text-white">Speedy Carrier Growth</li>
                        </ul>
                    </div>
                </div>
                <div className='col-12 col-sm-12 col-md-12 col-lg-5'>
                    <div className='relaxation-img'>
                        <img src='Assets/Images/relax_zone_img.png' alt='Gift Image' className='w-100' />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section className='products-line'>
        <div className='container'>
            <div className='text-start'>
                <h3 className='font-30'>Choose from our Various Products Line</h3>
            </div>
            <div className='row'>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>01</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Head & Eye Massager</h4>
                            <p className='font-16 pb-0'>imulation of human massage technique, Fully relax your head muscles, Pressure massage, enhance comfort, help relax the muscles.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>02</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Neck & Shoulder Massager</h4>
                            <p className='font-16 pb-0'>Powerful Kneading and shiatsu massage for effective relief of neck, shoulder, lumber, abdomen, and leg aches.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>03</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Massage Pad</h4>
                            <p className='font-16 pb-0'>The rays not only benefit the muscles on the surface of the body but deeper parts of our body.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>04</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Massage Chair</h4>
                            <p className='font-16 pb-0'>It's a complete solution for your body relaxation. Our chair massager has the 3D massage which helps in relieving the pain.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>05</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Wireless Massage Gun</h4>
                            <p className='font-16 pb-0'>Four interchangeable massage heads, an ergonomic portable massage gun the most powerful can soothe your stiff muscles in minutes.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>06</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Unique Palm Massager</h4>
                            <p className='font-16 pb-0'>It is a handheld electric body massager that helps to relieve body pain and promotes blood circulation.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>07</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Electro Thermal Water Bag</h4>
                            <p className='font-16 pb-0'>An electric hot water pouch is a pouch filled & sealed with special gel, used to provide warmth.</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>08</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Knee Massager</h4>
                            <p className='font-16 pb-0'>Through the air bag extrusion on both sides to accelerate blood ciculation and relieve knee pain</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>09</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Foot Massager</h4>
                            <p className='font-16 pb-0'>Innovative feet massaging features that focus on giving relief for achy, cold this machine offers deep kneading Shiatsu massage that soothes your feet</p>
                        </div>
                    </div>
                </div>
                <div className='col-12 col-sm-6 col-md-6 col-lg-3 mb-5'>
                    <div className='products-line-cart'>
                        <h5>10</h5>
                        <div className='text-center'>
                            <h4 className='font-18 text-black'>Full Body Shaper & Massager</h4>
                            <p className='font-16 pb-0'>This massager is one of the powerful massager which can also be used for fat reduction from different parts of the body.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section className='products-line-contact'>
        <p className='font-30 mb-0 pb-0 text-white'>Choose from our Various Products Line <a href='/contact-us' className='btn-white ms-5'>contact us</a></p>
    </section>

    <section className='need-relaxation mt-5 mb-5'>
      <div className='container'>
        <div className='row align-items-center'>          
          <div className='col-12 col-sm-12 col-md-12 col-lg-7'>
            <div className='relaxation-content text-start ms-5'>
                <h3 className="font-30 pb-3">Why do we need Relaxation ?</h3>
                <ul className='m-0 ps-2'>
                    <li className="products-details-black text-start text-body-tertiary">In a world of go-go-go, there’s not much time left to relax between work and endless to-do lists.</li>
                    <li className="products-details-black text-start text-body-tertiary">To some people, it may seem like a waste of time, but putting in that little bit of effort can make those few minutes of relaxation well worth it</li>                
                    <li className="products-details-black text-start text-body-tertiary">Take a look at why relaxing is important and how you can enjoy these benefits. Without relaxation you can remain tired, stressed, unhealthy and get sick more often.</li>                
                    <li className="products-details-black text-start text-body-tertiary">Many say rest is as important as the work we do day to day as without it, we wouldn’t be effective.</li>
                </ul>
            </div>
          </div> 
          <div className='col-12 col-sm-12 col-md-12 col-lg-5'>
            <div className='relaxation-img'>
              <img src='Assets/Images/need_relaxation.png' alt='Gift Image' className='w-100'/>
            </div>
          </div>         
        </div>
      </div>
      <div className='relaxation-wrapper'>
        <div className='container'>
          <div className='row align-items-center'>          
            <div className='col-12 col-sm-12 col-md-4 col-lg-4'>
                <div className='relaxation-card'>
                  <div className='relaxation-card-img'>
                    <img src='Assets/Images/relaxation_one.svg' alt='Relaxation Card Image'/>
                  </div>                
                  <div className='relaxation-card-body'>
                    <ul>
                      <li className='font-18 text-black lh-sm'>It  Boosts your productivity</li>
                      <li className='font-18 text-black lh-sm'>It enhance the blood flow</li>
                    </ul>
                  </div>
                </div>
            </div>
            <div className='col-12 col-sm-12 col-md-4 col-lg-4'>
                <div className='relaxation-card'>
                  <div className='relaxation-card-img'>
                    <img src='Assets/Images/relaxation_two.svg' alt='Relaxation Card Image'/>
                  </div>                
                  <div className='relaxation-card-body'>
                    <ul>
                      <li className='font-18 text-black lh-sm'>It Improves Memory & work efficiency.</li>
                      <li className='font-18 text-black lh-sm'>It Boosts & nurture good Health.</li>
                    </ul>
                  </div>
                </div>
            </div>
            <div className='col-12 col-sm-12 col-md-4 col-lg-4'>
                <div className='relaxation-card'>
                  <div className='relaxation-card-img'>
                    <img src='Assets/Images/relaxation_three.svg' alt='Relaxation Card Image'/>
                  </div>                
                  <div className='relaxation-card-body'>
                    <ul>
                      <li className='font-18 text-black lh-sm'>It Improves Your Well-Being</li>
                      <li className='font-18 text-black lh-sm'>Lower your risk of vital & life threating disease</li>
                    </ul>
                  </div>
                </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section className='great-earning'>
      <div className='container-fluid'>
        <div className='row align-items-center'>
          <div className='col-12 col-sm-12 col-md-12 col-lg-5'>
            <div className='great-earning-img'>
              <img src='Assets/Images/great_earning.png' alt='Gift Image' className='w-85'/>
              <a href='#' className='youtube-btn'>
                <img src='Assets/Images/youtube-button.svg' alt='Youtube Video'/>
              </a>
            </div>
          </div>
          <div className='col-12 col-sm-12 col-md-12 col-lg-7'>
            <div className='great-earning-content text-start ms-5'>
                <h3 className="font-30 pb-3 lh-sm">Great earning opportunities to be partner with DR.BWC through franchises</h3>
                <ul className='m-0 ps-2'>
                    <li className="products-details-black text-start text-body-tertiary">As we provide health & wellness solutions by proper tuning of natural resources at very affordable rates, lets spread this all over and become a part of a Healthy & Happy Life.</li>
                    <li className="products-details-black text-start text-body-tertiary">We provide franchisees at a very low investment and handsome returns. In order to maintain affordable membership packages to visitors, but still not compromise our partners earnings, we have provided them with 2 other income sources through which they can earn good. There are overall 3 different ways through which franchisees can earn incomes with us as given below</li>                
                    <li className="products-details-black text-start text-body-tertiary">1) Primarily, Our economically designed wellness membership package services to the visitors and people seeking relaxation.</li>                
                    <li className="products-details-black text-start text-body-tertiary">2) 10% to 30% margins in equipment selling.</li>
                    <li className="products-details-black text-start text-body-tertiary">3) Franchisee referral income.</li>
                </ul>
            </div>
          </div>          
        </div>
      </div>
    </section>

    </>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
