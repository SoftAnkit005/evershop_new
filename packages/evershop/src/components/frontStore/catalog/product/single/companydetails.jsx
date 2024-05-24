import PropTypes from 'prop-types';
import React from 'react';

export function companydetails({ companydetails }) {

  return (   

    <section className='related-products'>
        <div className='row align-items-center'>
            <div className='col-12'>
                <h4 className="font-20 pb-0 text-brawn">Company details</h4>
                <p className='font-16 mt-2'>{companydetails}</p>
                <hr/>
            </div>
        </div>
    </section> 
  );
}

companydetails.propTypes = {
    companydetails: PropTypes.string.isRequired
};
