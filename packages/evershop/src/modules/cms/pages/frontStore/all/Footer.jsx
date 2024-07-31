import React, { useEffect, useState } from 'react';
import PropTypes from 'prop-types';


function Footer({ themeConfig: { copyRight }, menu }) {

    const [finalURL, setFinalURL] = useState('');
    const [sortedMenu, setsortedMenu] = useState([])

    useEffect(() => {
        const currentURL = window.location.href;
        const newURL = currentURL.replace(currentURL, '');
        const pathStartIndex = newURL.indexOf('/', 8);
        const newPath = newURL.substring(pathStartIndex);
        const finalURL = window.location.origin + newPath;
        setFinalURL(finalURL);
        setsortedMenu(menu.items.sort((a, b) => a.position - b.position))
    }, []);
    
    return (

        <>
            <div className='container-fluid'>
                <div className='row'>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-3'>
                        <div className='footer-menu'>
                            <div className='footer-logo mb-4'>
                                <img src={`${finalURL}/Assets/Images/header_logo.svg`} alt='Footer Logo' />
                            </div>
                            <p className='footer-link'>Wellness Care products are a result of an in-depth and voluminous research on various ancient Oriental Healing Practices.</p>
                            <div className='social-media'>
                                <h5 className='footer-title'>Follow Us On</h5>
                                <ul className='list-unstyled m-0 p-0'>
                                    <li>
                                        <a href='https://www.facebook.com/profile.php?id=100083215367869&mibextid=ZbWKwL' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/facebook.svg`} alt='Facebook' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://x.com/BhanusaliW' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/twitter.svg`} alt='Twitter' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://www.instagram.com/dr.bwc?igsh=NmF5ZmhuZXJkNzZw' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/instagram.svg`} alt='Instagram' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://youtube.com/@drbwc?si=ZnYNbRJqidVOIij0' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/youtube.svg`} alt='Youtube' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://www.linkedin.com/in/dr-bwc-a3428a1a6?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/linkedin.svg`} alt='Linkedin' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://api.whatsapp.com/send?phone=919909993597&text=I%20come%20from%20drbwc.com' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/whatsapp.svg`} alt='Whatsapp' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://dl.flipkart.com/dl/product/p/itme?pid=MCHGSKPKFQHDGZYH&lid=LSTMCHGSKPKFQHDGZYHIZ2E4O' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/flipkart.svg`} alt='Flipkart' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='https://www.amazon.in/Automatic-Robotic-Gravity-Massage-Heating/dp/B0CMH545YP/ref=mp_s_a_1_5?crid=31AFPQPAYXBVN&keywords=dr+bwc+massage+chair&qid=1703226247&sprefix=dr+bwc+massage+chair%2Caps%2C198&sr=8-5' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/amazon.svg`} alt='Amazon' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/justdial.svg`} alt='Justdial' />
                                        </a>
                                    </li>
                                    <li>
                                        <a href='' target='_blank'>
                                            <img src={`${finalURL}/Assets/Images/gem.svg`} alt='Government e Marketplace' />
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div className='col-12 col-sm-4 col-md-4 col-lg-3'>
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
                    <div className='col-12 col-sm-4 col-md-4 col-lg-3'>
                        <div className='footer-menu categories-menu'>
                            <h5 className='footer-title'>Categories</h5>
                            <ul className='list-unstyled m-0 p-0'>
                                <li>
                                    <a href='/' className='footer-link fade-left'>Home</a>
                                </li>
                                <li>
                                    <a href='/automatic-thermal-massage-bed' className='footer-link fade-left'>Automatic Thermal Massager</a>
                                </li>
                                {sortedMenu.map((item, i) => 
                                    <li key={i}>
                                        <a href={item.url} className='footer-link fade-left'>{item.name}</a>
                                    </li>
                                )}
                            </ul>
                        </div>
                    </div>
                    <div className='col-12 col-sm-4 col-md-4 col-lg-3'>
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
                    {/* <div className='col-12 col-sm-12 col-md-12 col-lg-3'>
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
                    </div> */}
                </div>
            </div>
            <p className="copyright">Copyright @ 2022 Dr.BWC | Designed By <a className='copyright-developers' target="_blank" href='https://softieons.com/' alt="softieons team">Softieons</a></p>
        </>
    );
}


Footer.propTypes = {
    themeConfig: PropTypes.shape({
        copyRight: PropTypes.string
    }),
    menu: PropTypes.shape({
        items: PropTypes.arrayOf(
          PropTypes.shape({
            name: PropTypes.string.isRequired,
            url: PropTypes.string.isRequired
          })
        ).isRequired
      }).isRequired
};

Footer.defaultProps = {
    themeConfig: {
        copyRight: 'Copyright @ 2022 Bhanusaliwellness | Designed By Softieons'
    },
    menu: PropTypes.shape({
        items: PropTypes.arrayOf(
          PropTypes.shape({
            name: PropTypes.string.isRequired,
            url: PropTypes.string.isRequired
          })
        ).isRequired
      }).isRequired
};



export const layout = {
    areaId: 'footer',
    sortOrder: 10
};

export const query = `
    query {
      menu {
        items {
            name
            url
            parent_id
            position
            children {
                name
                url
                parent_id        
            }
        }
      }
    }
  `;

export default Footer;

