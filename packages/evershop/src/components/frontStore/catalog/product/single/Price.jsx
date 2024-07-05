import PropTypes from 'prop-types';
import React from 'react';
import { BiSolidOffer } from 'react-icons/bi';
// import Offers from 'Assets/Images/offers.svg'

export function Price({ regular, special }) {
  return (
    <>
      <p className='fs-4 fw-medium flex items-center mb-0'>Special rate <BiSolidOffer className='fs-1 ms-2 text-brawn' /></p>
      <h4 className="font-24 text-black mt-2">
        {special.value === regular.value && (
          <div className='d-flex align-items-center'>
            <span className="sale-price">{regular.text}</span>
            <h5 className='font-14 text-danger ms-3 mb-0'>20% OFF</h5>
            <span className='font-14 mt-0 pb-0 ms-3'>Incl. of all taxes</span>
          </div>
        )}
        {special.value < regular.value && (
          <div className='d-flex align-items-center'>
            <span className="sale-price">{special.text}</span>{' '}
            <span className="regular-price">{regular.text}</span>
            <h5 className='font-14 text-danger ms-3 mb-0'>20% OFF</h5>
            <span className='font-14 mt-0 pb-0 ms-3'>Incl. of all taxes</span>
          </div>
        )}
      </h4>
      <p className="font-18 m-0 text-black">EMI <span className='font-14 mt-0 pb-0 ms-3'>Starts at {regular.text} per month</span></p>
      <hr />
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
