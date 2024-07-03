import PropTypes from 'prop-types';
import React from 'react';

export function Price({ regular, special }) {
  return (
    <>
      <p className='font-18 text-brawn pb-0'>special rate</p>
      <h4 className="font-24 text-black mt-2">
        {special.value === regular.value && (
          <div className='d-flex align-items-center'>
            <span className="sale-price">{regular.text}</span>
            <h5 className='font-14 text-danger ms-3 mb-0'>20% OFF</h5>
            <span className='font-16 mt-0 pb-0 ms-3'>Incl. of all taxes</span>
          </div>
        )}
        {special.value < regular.value && (
          <div className='d-flex align-items-center'>
            <span className="sale-price">{special.text}</span>{' '}
            <span className="regular-price">{regular.text}</span>
            <h5 className='font-14 text-danger ms-3 mb-0'>20% OFF</h5>
            <span className='font-16 mt-0 pb-0 ms-3'>Incl. of all taxes</span>
          </div>
        )}
      </h4>
      <p className="font-18 text-black">EMI <span className='font-16 mt-0 pb-0 ms-3'>Starts at {regular.text} per month</span></p>
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
