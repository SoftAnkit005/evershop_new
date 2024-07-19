import axios from 'axios';
import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import { BiSolidOffer } from 'react-icons/bi';
// import Offers from 'Assets/Images/offers.svg'

export function Price({ regular, special, amazonLink, flipkartLink, sku }) {
  const [finalURL, setFinalURL] = useState('');
  const [couponData, setCouponData] = useState(null);
  const [offerCount, setofferCount] = useState(0)

  useEffect(() => {
    const currentURL = window.location.href;
    const newURL = currentURL.replace(currentURL, '');
    const pathStartIndex = newURL.indexOf('/', 8);
    const newPath = newURL.substring(pathStartIndex);
    const finalurl = window.location.origin + newPath;
    setFinalURL(finalurl);
   
    const fetchData = async () => {
      try {
        const response = await axios.get(`${finalurl}/api/getcoupondata`);
        setCouponData(response.data);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };
    fetchData();
  }, []);

  return (
    <>
      <p className='fs-4 fw-medium flex items-center mb-0'>Special rate <BiSolidOffer className='fs-1 ms-2 text-brawn' /></p>
      <h4 className="font-24 text-black mt-3">
        {special.value === regular.value && (
          <>
            <div className='d-flex align-items-start'>
              <span className="sale-price font-medium">{regular.text}</span>
              <h5 className='font-12 text-danger ms-2 mb-0'>20% OFF</h5>
            </div>
            <div className='font-12 mt-3 pb-0'>Inclusive of all taxes</div>
          </>
        )}
        {special.value < regular.value && (
          <div className='d-flex align-items-center'>
            <span className="sale-price font-medium">{special.text}</span>{' '}
            <span className="regular-price">{regular.text}</span>
            <h5 className='font-12 text-danger ms-3 mb-0'>20% OFF</h5>
            <span className='font-12 mt-0 pb-0 ms-3'>Inclusive of all taxes</span>
          </div>
        )}
      </h4>
      <p className="font-18 m-0 text-black">EMI <span className='font-12 mt-0 pb-0 ms-3'>Starts at {regular.text} per month</span></p>
      <div className="border rounded-3 mt-3">
        {(couponData !== null && couponData !== undefined)?
          <>
            <div className='d-flex align-items-center border-bottom p-2'>
              <BiSolidOffer className='fs-1 ms-2 text-theme-red' /> <span className='font-13 fw-normal text-dark'>Sale with extra</span><span className='font-13 font-semibold text-theme-red ms-2'> Offers</span>
            </div>
            {couponData.map((item, index) => (
              <div key={index}>
                {(item.discount_type === "fixed_discount_to_entire_order") ? 
                  (
                    <div className='d-flex align-items-center border-bottom p-2'>
                      <span className='font-13 fw-normal text-dark'>{item.description}</span>
                    </div>
                  ) : (item.discount_type === "percentage_discount_to_specific_products" && item.target_products.products[0].value[0] !== undefined && item.target_products.products[0].value[0] === sku) ? (
                    <div className='d-flex align-items-center border-bottom p-2'>
                      <span className='font-13 fw-normal text-dark'>{item.description}</span>
                    </div>
                  ) : (
                    <></>
                )}
              </div>
            ))}
          </>
          :
          <></>
        }
      </div>
      <div className='d-flex align-items-center'>
        {(flipkartLink !== null)?
          <a href={flipkartLink} target='_blank'><img className='mt-3' src={`${finalURL}/Assets/Images/flipkart-logo.png`}  alt='flipkart' style={{height:'30px'}}/></a>
          :
          <></>
        }
        {(amazonLink !== null)?
          <a href={amazonLink} target='_blank'><img className='mt-3 ms-3' src={`${finalURL}/Assets/Images/amazon-logo.png`}  alt='flipkart' style={{height:'30px'}}/></a>
          :
          <></>
        }
      </div>
      <hr className='my-4'/>
    </>
  );
}

Price.propTypes = {
  regular: PropTypes.shape({
    value: PropTypes.number.isRequired,
    text: PropTypes.string.isRequired
  }).isRequired,
  special: PropTypes.shape({
    value: PropTypes.number.isRequired,
    text: PropTypes.string.isRequired
  }).isRequired
};
