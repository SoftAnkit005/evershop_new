import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';

export function companydetails({ companydetails }) {

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

    <section className='related-products'>
      <div className='row align-items-center'>
        <div className='col-12'>
          <h4 className="font-20 pb-0 text-brawn">Company details</h4>
          <p className='font-16 mt-2'>{companydetails}</p>
          <hr />
        </div>
      </div>

      <div className='delivery-info'>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/Wishlist.svg`} alt='Warranty' />
          </div>
          <p className='font-16 lh-sm mt-4'>3 Year Warranty Care</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/Wishlist.svg`} alt='Warranty' />
          </div>
          <p className='font-16 lh-sm mt-4'>Quality <br />Verified</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/Wishlist.svg`} alt='Warranty' />
          </div>
          <p className='font-16 lh-sm mt-4'>Assemble <br />Available</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/Wishlist.svg`} alt='Warranty' />
          </div>
          <p className='font-16 lh-sm mt-4'>Dr.BWC <br />Deliverd</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/Wishlist.svg`} alt='Warranty' />
          </div>
          <p className='font-16 lh-sm mt-4'>Free <br />Delivery</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/Wishlist.svg`} alt='Warranty' />
          </div>
          <p className='font-16 lh-sm mt-4'>Secure <br />Transaction</p>
        </div>
      </div>
    </section>

  );
}

companydetails.propTypes = {
  companydetails: PropTypes.string.isRequired
};
