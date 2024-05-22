import PropTypes from 'prop-types';
import React from 'react';
import Area from '@components/common/Area';
import Button from '@components/common/form/Button';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import { Tax } from '@components/frontStore/checkout/checkout/summary/cart/Tax';
import { Total } from '@components/frontStore/checkout/checkout/summary/cart/Total';
import './../../../../Styles/Styles.scss'

function Subtotal({ subTotal }) {
  return (    
    <ul className="list-unstyled mb-0">
      <li className="font-18 text-black mb-0">{_('Sub total')}</li>
      <li className="font-18 text-black mb-0">{subTotal.text}</li>
    </ul>
  );
}

Subtotal.propTypes = {
  subTotal: PropTypes.number
};

Subtotal.defaultProps = {
  subTotal: 0
};

function Discount({ discountAmount, coupon }) {
  if (!coupon) {
    return null;
  }
  return (
    <div className="flex justify-between gap-3">
      <div>{_('Discount(${coupon})', { coupon })}</div>
      <div className="text-right">{discountAmount.text}</div>
    </div>
  );
}

Discount.propTypes = {
  discountAmount: PropTypes.number,
  coupon: PropTypes.string
};

Discount.defaultProps = {
  discountAmount: 0,
  coupon: ''
};

function Summary({
  checkoutUrl,
  cart: {
    totalQty,
    subTotal,
    subTotalInclTax,
    taxAmount,
    grandTotal,
    coupon,
    discountAmount
  },
  setting: { displayCheckoutPriceIncludeTax }
}) {
  if (totalQty === undefined || totalQty <= 0) {
    return null;
  }
  return (
    <div className="modal-footer border-top-0 justify-content-start">
        <h5 className='order-summary text-brawn text-start'>{_('Order summary')}</h5>
        <Area
          id="shoppingCartSummary"
          noOuter
          coreComponents={[
            {
              component: { default: Subtotal },
              props: {
                subTotal: displayCheckoutPriceIncludeTax
                  ? subTotalInclTax
                  : subTotal
              },
              sortOrder: 10,
              id: 'shoppingCartSubtotal'
            },
            {
              component: { default: Discount },
              props: { discountAmount, coupon },
              sortOrder: 20,
              id: 'shoppingCartDiscount'
            },
            {
              // eslint-disable-next-line react/no-unstable-nested-components
              component: {
                default: displayCheckoutPriceIncludeTax ? () => null : Tax
              },
              props: {
                amount: taxAmount.text
              },
              sortOrder: 30,
              id: 'tax'
            },
            {
              // eslint-disable-next-line react/no-unstable-nested-components
              component: {
                default: Total
              },
              props: {
                total: grandTotal.text,
                taxAmount: taxAmount.text,
                displayCheckoutPriceIncludeTax
              },
              sortOrder: 30,
              id: 'tax'
            }
          ]}
        />
        <ul className='list-unstyled m-0'>            
            <li className='font-18 text-black m-0 w-100 text-center'>
                <Button url={checkoutUrl} title={_('Checkout')} variant="primary" />
            </li>
        </ul>
    </div>

  );
}

Summary.propTypes = {
  checkoutUrl: PropTypes.string.isRequired,
  cart: PropTypes.shape({
    totalQty: PropTypes.number,
    subTotal: PropTypes.shape({
      value: PropTypes.number,
      text: PropTypes.string
    }),
    subTotalInclTax: PropTypes.shape({
      value: PropTypes.number,
      text: PropTypes.string
    }),
    taxAmount: PropTypes.shape({
      value: PropTypes.number,
      text: PropTypes.string
    }),
    discountAmount: PropTypes.shape({
      value: PropTypes.number,
      text: PropTypes.string
    }),
    coupon: PropTypes.string,
    grandTotal: PropTypes.shape({
      value: PropTypes.number,
      text: PropTypes.string
    })
  }).isRequired,
  setting: PropTypes.shape({
    displayCheckoutPriceIncludeTax: PropTypes.bool
  }).isRequired
};

export default Summary;

export const layout = {
  areaId: 'shoppingCartRight',
  sortOrder: 10
};

export const query = `
  query Query {
    cart(id: getContextValue('cartId', null)) {
      totalQty
      subTotal {
        value
        text
      }
      grandTotal {
        value
        text
      }
      subTotalInclTax {
        value
        text
      }
      taxAmount {
        value
        text
      }
      discountAmount {
        value
        text
      }
      coupon
    }
    setting {
      displayCheckoutPriceIncludeTax
    }
    checkoutUrl: url(routeId: "checkout")
  }
`;
