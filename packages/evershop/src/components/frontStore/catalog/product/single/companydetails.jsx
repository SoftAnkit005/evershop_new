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
      <div className='delivery-info border-bottom'>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/warranty_care.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>3 Year Warranty Care</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/quality_verified.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>Quality <br />Verified</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/assemble_available.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>Assemble <br />Available</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/replce.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>No Replacement</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/top-brand.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>Top Brand</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/drbwc_deliverd.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>Dr.BWC <br />Deliverd</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/free_delivery.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>Free <br />Delivery</p>
        </div>
        <div className='delivery-list'>
          <div className='info-icon'>
            <img src={`${finalURL}/Assets/Images/secure_transaction.svg`} alt='Warranty' />
          </div>
          <p className='font-13 text-dark lh-sm my-3'>Secure <br />Transaction</p>
        </div>
      </div>

      <div className='row align-items-center my-4'>
        <div className='col-12'>
          <h4 className="font-20 pb-0 text-brawn">About this item</h4>
          <p className='font-13 text-dark mt-2'>{companydetails}</p>
        </div>
      </div>
    </section>

  );
}

companydetails.propTypes = {
  companydetails: PropTypes.string.isRequired
};
