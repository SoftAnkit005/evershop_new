
import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';




import "../../../../Styles/Styles.scss";
// import './../../../../Styles/my_bootstrap.css';
// import '../../../../Styles/my_bootstrap_js.js';



export default function FeaturedOffer() {
 
  return (

    <section className='offer-section'>
            <div className='container'>
                <div className='text-center'>
                    <h2 className='products-title-black'>Offers</h2>
                    <h3 className='products-subtitle-black'>Sale Offers</h3>
                    <p className='products-details-black'>They have already used our services.</p>
                </div>
                <div className='row align-items-center mt-0 mt-md-5 mt-lg-5'>
                    <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                        <div className='offer-image'>
                            <img src='Assets/Images/offer_one.png' alt='Offer Image' className='w-100'/>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-6 col-lg-6 mt-4 mt-md-0 mt-lg-0'>
                        <div className='offer-image'>
                            <img src='Assets/Images/offer_two.png' alt='Offer Image' className='w-100'/>
                        </div>
                    </div>
                </div>
            </div>
        </section>
  );
}
export const layout = {
  areaId: 'content',
  sortOrder: 12
};