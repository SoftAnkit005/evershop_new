import React, { useEffect, useState } from 'react';
import PropTypes from 'prop-types';


function Footer({ themeConfig: { copyRight } }) {

    const [finalURL, setFinalURL] = useState('');

    useEffect(() => {
        const currentURL = window.location.href;
        const newURL = currentURL.replace(currentURL, '');
        const pathStartIndex = newURL.indexOf('/', 8);
        const newPath = newURL.substring(pathStartIndex);
        const finalURL = window.location.origin + newPath;
        setFinalURL(finalURL);
    }, []);


    return (

        <>
            <div className='container-fluid'>
                <div className='row'>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-4'>
                        <div className='footer-menu'>
                            <div className='footer-logo mb-4'>
                                <img src={`${finalURL}/Assets/Images/header_logo.svg`} alt='Footer Logo' />
                            </div>
                            <p className='footer-link'>Wellness Care products are a result of an in-depth and voluminous research on various ancient Oriental Healing Practices.</p>
                            <div className='social-media'>
                                <h5 className='footer-title'>Follow Us On</h5>
                                <ul className='list-unstyled m-0 p-0'>
                                    <li>
                                        <a href='https://www.facebook.com/DrBhanusaliwellnesscare' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/facebook.svg`} alt='Facebook' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://x.com/BhanusaliW' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/twitter.svg`} alt='Twitter' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://www.instagram.com/dr.bhanusaliwellnesscare/' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/instagram.svg`} alt='Instagram' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://www.youtube.com/channel/UC8y20B0YMniVdUqnfbwDjzg' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/youtube.svg`} alt='Youtube' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://www.linkedin.com/in/bhanusali-wellness-b72a25234/' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/linkedin.svg`} alt='Linkedin' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://api.whatsapp.com/send?phone=919909993597&text=I%20come%20from%20drbwc.com' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/whatsapp.svg`} alt='Whatsapp' />
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-3 col-lg-2'>
                        <div className='footer-menu usefull-menu'>
                            <h5 className='footer-title'>Usefull links</h5>
                            <ul className='list-unstyled m-0 p-0'>
                                <li>
                                    <a href='/about' className='footer-link fade-left'>About Us</a>
                                </li>
                                <li>
                                    <a href='/gallery' className='footer-link fade-left'>Gallery</a>
                                </li>
                                <li>
                                    <a href='/contact-us' className='footer-link fade-left'>Contact Us</a>
                                </li>
                                <li>
                                    <a href='/terms-conditions' className='footer-link fade-left'>Terms & Conditions</a>
                                </li>
                                <li>
                                    <a href='/shipping-policy' className='footer-link fade-left'>Shipping Policy</a>
                                </li>
                                <li>
                                    <a href='/privacy-policy' className='footer-link fade-left'>Privacy Policy</a>
                                </li>
                                <li>
                                    <a href='/refund-policy' className='footer-link fade-left'>Refund Policy</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-3 col-lg-2'>
                        <div className='footer-menu categories-menu'>
                            <h5 className='footer-title'>Categories</h5>
                            <ul className='list-unstyled m-0 p-0'>
                                <li>
                                    <a href='/' className='footer-link fade-left'>Home</a>
                                </li>
                                <li>
                                    <a href='/massage-chair' className='footer-link fade-left'>Massage Chair</a>
                                </li>
                                <li>
                                    <a href='/thermal-heating-bed' className='footer-link fade-left'>Thermal Heading Bed</a>
                                </li>
                                <li>
                                    <a href='/thermal-heating-bed' className='footer-link fade-left'>Foot & Leg Massager</a>
                                </li>
                                <li>
                                    <a href='/salon-spa-jacuzzi' className='footer-link fade-left'>Salon Spa Jacuzzi</a>
                                </li>
                                <li>
                                    <a href='/gym-products' className='footer-link fade-left'>Gym Products</a>
                                </li>
                                <li>
                                    <a href='/new-arrivals' className='footer-link fade-left'>New Arrivals</a>
                                </li>
                                <li>
                                    <a href='/corporate-gifts' className='footer-link fade-left'>Corporate Gifts</a>
                                </li>
                                <li>
                                    <a href='/franchise-opportunity' className='footer-link fade-left'>Franchise Opportunity</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-3 col-lg-2'>
                        <div className='footer-menu'>
                            <h5 className='footer-title'>About Company</h5>
                            <p className='footer-link'>VIP Road,Vesu,Surat Gujrat,395007 India</p>
                        </div>
                        <div className='footer-menu'>
                            <h5 className='footer-title'>Email</h5>
                            <p className='footer-link'><a href='mailto:info@DrBWC.com'>info@DrBWC.com</a></p>
                        </div>
                        <div className='footer-menu'>
                            <h5 className='footer-title'>Toll free number</h5>
                            <p className='footer-link'><a href='callto:18004195973'>18004195973</a></p>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-3 col-lg-2'>
                        <div className='footer-menu'>
                            <h5 className='footer-title'>Payment option</h5>
                        </div>
                        <div className='payment-option'>
                            <ul>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/Visa.png`} alt='Visa' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/MasterCard.png`} alt='MasterCard' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/AmericanExpress.png`} alt='AmericanExpress' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/Maestro.png`} alt='Maestro' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/GPay.png`} alt='GPay' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/Bhim.png`} alt='Bhim' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/Bhim.png`} alt='PhonePe' /></a>
                                </li>
                                <li>
                                    <a href="#"><img src={`${finalURL}/Assets/Images/Paytm.png`} alt='Paytm' /></a>
                                </li>
                            </ul>
                        </div>
                        <div className='footer-menu mt-5'>
                            <h5 className='footer-title'>WHY SHOP WITH US?</h5>
                        </div>
                        <div className='footer-link'>
                            <p className='m-0'>We Provide Free Shipping throughout PAN India and Minimal cost for International Shipping</p>
                        </div>
                    </div>
                </div>
            </div>
            <p className='copyright'>{copyRight}</p>
        </>
    );
}


Footer.propTypes = {
    themeConfig: PropTypes.shape({
        copyRight: PropTypes.string

    })
};

Footer.defaultProps = {
    themeConfig: {
        copyRight: 'Copyright @ 2022 Bhanusaliwellness | Designed By Softieons'
    }
};



export const layout = {
    areaId: 'footer',
    sortOrder: 10
};

export const query = `
    query query {
      themeConfig {
        copyRight,
      }
    }
  `;

export default Footer;

