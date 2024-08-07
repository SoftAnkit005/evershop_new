import { Card } from '@components/admin/cms/Card';
import { Form } from '@components/common/form/Form';
import { useModal } from '@components/common/modal/useModal';
import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import { BiSolidOffer } from 'react-icons/bi';
import { IoClose } from 'react-icons/io5';
// import Offers from 'Assets/Images/offers.svg'

export function Price({ regular, special, amazonLink, flipkartLink, sku , coupons}) {
  
  const currentDate = new Date().getTime();; // Timestamp to check
  
  const [finalURL, setFinalURL] = useState('');
  const [modalHeading, setmodalHeading] = useState("")
  const [modalData, setmodalData] = useState("")
  const modal = useModal();

  return (
    <>
      <p className='fs-4 fw-medium flex items-center mb-0 blink'>Special rate <BiSolidOffer className='fs-1 ms-2 text-brawn' /></p>
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
      <div className='my-3 d-flex align-items-center'>
        <span className='font-13 font-semibold text-white bg-theme-red px-2 py-1 position-relative rounded-start coupon-badge'>Coupon: &nbsp;</span>
        <input className='ms-4 w-auto h-auto' type="checkbox" name="coupon_check" id="coupon_check" style={{appearance:'auto', WebkitAppearance:'auto'}} />
        <label for="coupon_check" className='font-12 mt-0 pb-0 ms-3'>Apply 10000 coupon</label>
        <span className='text-cadetblue font-12 ms-2'>Tearms | </span>
        <span className='text-cadetblue font-12 ms-2'>Shop Items</span>
      </div>
      <div className="border rounded-3 mt-3">
        {(coupons.items !== null && coupons.items !== undefined)?
          <>
            <div className='d-flex align-items-center border-bottom p-2'>
              <BiSolidOffer className='fs-1 ms-2 text-theme-red' /> <span className='font-13 fw-normal text-dark'>Sale with extra</span><span className='font-13 font-semibold text-theme-red ms-2'> Offers</span>
            </div>
            {coupons.items.map((item, index) => (
              <div key={index}>
                {(item.discount_type === "fixed_discount_to_entire_order" && currentDate >= item.start_date && currentDate <= item.end_date) ? 
                  (
                    <div className='d-flex align-items-center border-bottom p-2'>
                      <div className='font-13 font-semibold text-theme-red ms-2'>Coupon Offers : &nbsp;</div>
                      <span className='font-13 fw-normal text-dark'>{item.coupon_heading} | &nbsp;</span> 
                      <button className='text-cadetblue font-12' onClick={() => { modal.openModal(); setmodalHeading(item.coupon); setmodalData(item.description)}} >Details</button>
                    </div>
                  ) : (item.discount_type === "percentage_discount_to_specific_products" && item.target_products.products !== undefined && item.target_products.products[0].value[0] === sku && currentDate >= item.start_date && currentDate <= item.end_date) ? (
                    <div className='d-flex align-items-center border-bottom p-2'>
                      <span className='font-13 fw-normal text-dark'>{item.coupon_heading} | &nbsp;</span>
                      <button className='text-cadetblue font-12' onClick={() => { modal.openModal(); setmodalHeading(item.coupon); setmodalData(item.description)}} >Details</button>
                    </div>
                  ) : (
                    <></>
                )}
              </div>
            ))}
          </>
          :
          <></>
        }
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

      {modal.state.showing && (
          <div className={modal.className} onAnimationEnd={modal.onAnimationEnd}>
            <div
              className="modal-wrapper flex self-center justify-center items-center"
              tabIndex={-1}
              role="dialog"
            >
              <div className="modal">
                <Form id="variantForm" submitBtn={false}>
                  <Card title={
                        <div className='d-flex justify-content-between align-items-center'>
                          <span>{modalHeading}</span>
                          <button onClick={() => modal.closeModal()}><IoClose /></button>
                        </div>
                      }>
                    <Card.Session>
                      <p class="font-13 fw-normal text-dark p-4">{modalData}</p>
                    </Card.Session>
                  </Card>
                </Form>
              </div>
            </div>
          </div>
        )}
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