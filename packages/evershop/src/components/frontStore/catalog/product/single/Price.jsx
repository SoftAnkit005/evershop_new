import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import { BiSolidOffer } from 'react-icons/bi';
// import Offers from 'Assets/Images/offers.svg'

export function Price({ regular, special, amazonLink, flipkartLink }) {
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
        <div className='d-flex align-items-center border-bottom p-2'>
          <BiSolidOffer className='fs-1 ms-2 text-theme-red' /> <span className='font-13 font-semibold text-theme-red ms-2'>Sale Extra <span className='fw-normal text-lowercase text-dark'>with 3 offers</span></span>
        </div>
        <div className='d-flex align-items-center border-bottom p-2'>
          <span className='font-13 font-semibold text-theme-red ms-2'>Bank Offer: <span className='fw-normal text-lowercase text-dark'>Flat INR 4000 Instant Discount on HDFC Bank 12,18 month Credit Car</span></span>
        </div>
        <div className='d-flex align-items-center p-2'>
          <span className='font-13 font-semibold text-theme-red ms-2'>No Cost EMI: <span className='fw-normal text-lowercase text-dark'>Avail No Cost EMI on select cards for orders above ₹3000</span></span>
        </div>
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
