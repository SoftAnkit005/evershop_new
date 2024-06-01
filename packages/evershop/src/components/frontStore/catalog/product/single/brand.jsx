import PropTypes from 'prop-types';
import React from 'react';

export function brand({ usefor, powersource, material, itemweight, brand, specialfeature, specificusesforproduct, productbenefits, productdimensions }) {


    return (

        <section className='related-products wishlist-section'>
            <div className='row align-items-center'>
                <div className='col-12'>
                    <h4 className="font-20 pb-0 text-brawn">product description</h4>
                    <p className='font-16 mt-2'>Foot, Calf & Leg Massager, with Vibration & Heat, 3 Massage Levels, 4 motors, Corded Electric.</p>
                    <div className='border p-4 mb-5 rounded-4'>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Use for</li>
                            <li className='font-16 text-black w-50 text-start'>{usefor}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Power Source</li>
                            <li className='font-16 text-black w-50 text-start'>{powersource}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Material</li>
                            <li className='font-16 text-black w-50 text-start'>{material}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Item Weight</li>
                            <li className='font-16 text-black w-50 text-start'>{itemweight} Gram</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Brand</li>
                            <li className='font-16 text-black w-50 text-start'>{brand}</li>
                        </ul>

                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Special Feature</li>
                            <li className='font-16 text-black w-50 text-start'>{specialfeature}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Specific Uses For Product</li>
                            <li className='font-16 text-black w-50 text-start'>{specificusesforproduct}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Product Benefits</li>
                            <li className='font-16 text-black w-50 text-start'>{productbenefits}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-16 text-black w-50 text-start'>Product Dimensions</li>
                            <li className='font-16 text-black w-50 text-start'>{productdimensions} Centimeters</li>
                        </ul>





                    </div>
                    <hr className='mb-0' />
                </div>
            </div>
        </section>
    );
}

brand.propTypes = {
    brand: PropTypes.string.isRequired
};
