import PropTypes from 'prop-types';
import React from 'react';

function ProductsDetails({ name, url }) {
  return (   
    <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
        <div className='products-info text-center'>
            <h1 className='products-title-white'>Auto Wellness Program</h1>
            <h2 className='doc-name-white'>DR.BWC</h2>
            <a href={url}>
              <h3 className='products-subtitle-white'>{name}</h3>
            </a>
            <div className='mt-4'>
                <a href='#' className='btn-brown'>View All Products</a>
            </div>
        </div>
    </div>
  );
}

ProductsDetails.propTypes = {
  url: PropTypes.string,
  name: PropTypes.string
};

ProductsDetails.defaultProps = {
  url: '',
  name: ''
};

export { ProductsDetails };
