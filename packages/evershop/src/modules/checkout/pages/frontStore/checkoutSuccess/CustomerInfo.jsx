import PropTypes from 'prop-types';
import React from 'react';
import Button from '@components/common/form/Button';
import { AddressSummary } from '@components/common/customer/address/AddressSummary';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import "../../../../Styles/Styles.scss";
import "../../../../catalog/pages/frontStore/categoryView/Index.scss"
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';


export default function CustomerInfo({
  order: {
    orderNumber,
    customerFullName,
    customerEmail,
    paymentMethodName,
    shippingAddress,
    billingAddress
  }
}) {
  return (
    <div className="checkout-success-customer-info">
      <h3 className="thank-you flex justify-start space-x-2 items-center">
        <div className="">
          <svg height="36px" viewBox="0 0 384 384" width="36px" xmlns="http://www.w3.org/2000/svg"><path d="m192 384c105.863281 0 192-86.128906 192-192 0-18.273438-2.550781-36.28125-7.601562-53.527344-2.488282-8.480468-11.34375-13.351562-19.847657-10.863281-8.488281 2.480469-13.34375 11.367187-10.863281 19.847656 4.183594 14.328125 6.3125 29.320313 6.3125 44.542969 0 88.222656-71.777344 160-160 160s-160-71.777344-160-160 71.777344-160 160-160c32.0625 0 62.910156 9.375 89.207031 27.105469 7.320313 4.941406 17.273438 3 22.207031-4.320313 4.9375-7.328125 3.011719-17.273437-4.316406-22.210937-31.601562-21.308594-68.632812-32.574219-107.097656-32.574219-105.863281 0-192 86.128906-192 192s86.136719 192 192 192zm0 0"/><path d="m356.6875 36.6875-164.6875 164.679688-52.6875-52.679688c-6.25-6.246094-16.375-6.246094-22.625 0-6.246094 6.25-6.246094 16.375 0 22.625l64 64c3.128906 3.128906 7.214844 4.6875 11.3125 4.6875s8.183594-1.558594 11.3125-4.6875l176-176c6.246094-6.25 6.246094-16.375 0-22.625-6.25-6.246094-16.375-6.246094-22.625 0zm0 0"/></svg>
        </div>
        <div className="self-center ms-3">
          <span className='font-16 pb-0'>
            {_('Order #${orderNumber}', { orderNumber })}
          </span>
          <div className='font-18 text-black mt-0'>
            {_('Thank you ${name}!', {
              name: customerFullName || billingAddress?.fullName
            })}
          </div>
        </div>
      </h3>

      <div className="customer-info mt-3 mb-5">
        <div className="grid grid-cols-2 gap-3">
          <div className="grid grid-cols-1 gap-3">
            <div className="mb-2">
              <div className="mb-075">
                <h3 className="font-18 text-black">{_('Contact information')}</h3>
              </div>
              <div className="text-textSubdued font-16">
                {customerFullName || billingAddress?.fullName}
              </div>
              <div className="text-textSubdued font-16">{customerEmail}</div>
            </div>
            <div>
              <div className="mb-075">
                <h3 className="font-18 text-black">{_('Shipping Address')}</h3>
              </div>
              <div className="text-textSubdued font-16">
                <AddressSummary address={shippingAddress} />
              </div>
            </div>
          </div>
          <div className="grid grid-cols-1 gap-3">
            <div className="mb-2">
              <div className="mb-075">
                <h3 className="font-18 text-black">{_('Payment Method')}</h3>
              </div>
              <div className="text-textSubdued font-16">{paymentMethodName}</div>
            </div>
            <div>
              <div className="mb-075">
                <h3 className="font-18 text-black">{_('Billing Address')}</h3>
              </div>
              <div className="text-textSubdued font-16">
                <AddressSummary address={billingAddress} />
              </div>
            </div>
          </div>
        </div>
      </div>
      <Button url="/" title={_('CONTINUE SHOPPING')} />
    </div>
  );
}

CustomerInfo.propTypes = {
  order: PropTypes.shape({
    orderNumber: PropTypes.string.isRequired,
    customerFullName: PropTypes.string,
    customerEmail: PropTypes.string.isRequired,
    paymentMethodName: PropTypes.string.isRequired,
    shippingAddress: PropTypes.shape({
      fullName: PropTypes.string,
      postcode: PropTypes.string,
      telephone: PropTypes.string,
      country: PropTypes.shape({
        name: PropTypes.string,
        code: PropTypes.string
      }),
      province: PropTypes.shape({
        name: PropTypes.string,
        code: PropTypes.string
      }),
      city: PropTypes.string,
      address1: PropTypes.string,
      address2: PropTypes.string
    }),
    billingAddress: PropTypes.shape({
      fullName: PropTypes.string,
      postcode: PropTypes.string,
      telephone: PropTypes.string,
      country: PropTypes.shape({
        name: PropTypes.string,
        code: PropTypes.string
      }),
      province: PropTypes.shape({
        name: PropTypes.string,
        code: PropTypes.string
      }),
      city: PropTypes.string,
      address1: PropTypes.string,
      address2: PropTypes.string
    })
  }).isRequired
};

export const layout = {
  areaId: 'checkoutSuccessPageLeft',
  sortOrder: 10
};

export const query = `
  query Query {
    order (uuid: getContextValue('orderId')) {
      orderNumber
      customerFullName
      customerEmail
      paymentMethodName
      shippingAddress {
        fullName
        postcode
        telephone
        country {
          name
          code
        }
        province {
          name
          code
        }
        city
        address1
        address2
      }
      billingAddress {
        fullName
        postcode
        telephone
        country {
          name
          code
        }
        province {
          name
          code
        }
        city
        address1
        address2
      }
    }
  }
`;
