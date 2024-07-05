import PropTypes from 'prop-types';
import React from 'react';

export function brand({ usefor, powersource, material, itemweight, brand, specialfeature, specificusesforproduct, productbenefits, productdimensions }) {


    return (

        <section className='related-products wishlist-section mt-4'>
            <div className='row align-items-center'>
                <div className='col-12'>
                    <h4 className="font-20 p-0 text-brawn">product description</h4>
                    <div className='py-4'>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Use for</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{usefor}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Power Source</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{powersource}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Material</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{material}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Item Weight</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{itemweight} Gram</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Brand</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{brand}</li>
                        </ul>

                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Special Feature</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{specialfeature}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Specific Uses For Product</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{specificusesforproduct}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Product Benefits</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{productbenefits}</li>
                        </ul>
                        <ul className='list-unstyled mb-0 d-flex align-items-center justify-content-between'>
                            <li className='font-14 text-black w-50 text-start pb-1 lh-lg fw-semibold'>Product Dimensions</li>
                            <li className='font-14 w-50 text-start pb-1 lh-lg'>{productdimensions} Centimeters</li>
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
