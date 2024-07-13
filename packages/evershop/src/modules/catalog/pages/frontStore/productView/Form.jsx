/* eslint-disable jsx-a11y/anchor-is-valid */
/* eslint-disable no-param-reassign */
import PropTypes from 'prop-types';
import React, { useState } from 'react';
import { toast } from 'react-toastify';
import produce from 'immer';
import Area from '@components/common/Area';
import { Form } from '@components/common/form/Form';
import { Field } from '@components/common/form/Field';
import Button from '@components/common/form/Button';
import './Form.scss';
import { useAppDispatch, useAppState } from '@components/common/context/app';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import { LuMapPin } from "react-icons/lu";
import { Select } from '@components/common/form/fields/Select';


function ToastMessage({ thumbnail, name, qty, count, cartUrl, toastId }) {
  return (
    <div className="toast-mini-cart">
      <div className="top-head grid grid-cols-2">
        <div className="font-16 text-black pb-0">{_('JUST ADDED TO YOUR CART')}</div>
        <div className="self-center close flex justify-end">
          <a
            href="#"
            onClick={(e) => {
              e.preventDefault();
              toast.dismiss(toastId);
            }}
            aria-label="Dismiss toast"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="h-6 w-6"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                stroke="black"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </a>
        </div>
      </div>
      <div className="item-line flex justify-between align-items-center">
        <div className="popup-thumbnail flex justify-center">
          <img src={thumbnail} alt={name} />
        </div>
        <div className="item-info flex justify-between">
          <div className="name">
            <span className="font-bold">{name}</span>
          </div>
          <div className='font-16 pb-0'>{_('QTY: ${qty}', { qty })}</div>
        </div>
      </div>
      <a className="add-cart-popup-button btn-brown" href={cartUrl}>
        {_('VIEW CART (${count})', { count })}
      </a>
      <a
        className="add-cart-popup-continue text-center underline block font-16 pb-0"
        href="#"
        onClick={(e) => {
          e.preventDefault();
          toast.dismiss(toastId);
        }}
      >
        {_('Continue Shopping')}
      </a>
    </div>
  );
}

ToastMessage.propTypes = {
  cartUrl: PropTypes.string.isRequired,
  count: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  qty: PropTypes.number.isRequired,
  thumbnail: PropTypes.string.isRequired,
  toastId: PropTypes.string.isRequired
};

function AddToCart({ stockAvaibility, loading = false, error }) {
  const deliveryDate = new Date().getDate() + 4;
  const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
  let deliveryMonth = months[new Date().getMonth()];

  return (
    <div className="add-to-cart mt-4">
        <div className="font-12 p-0">Delivery: <span className='font-semibold'>{deliveryDate} - {deliveryDate + 2} {deliveryMonth}</span></div>
        <div className='font-12 mt-2 d-flex align-items-center text-cadetblue'><LuMapPin className='me-1'/> Pan India Delivery</div>
      <div className='special-price mt-4'>
        {(stockAvaibility === true) ?
          <p className='in-stock'>In Stock</p>
          :
          <p className='out-of-stock'>Out Of Stock</p>
        }
      </div>
      <div>
        <div className="row mt-4 mx-0">
          <div className="col-4 font-12 p-0 text-muted">Ships from</div>
          <div className="col-8 font-12 p-0 text-black">Dr Bhanusalis Wellness Care</div>
          <div className="col-4 font-12 p-0 text-muted">Sold by</div>
          <div className="col-8 font-12 p-0 text-black">Dr Bhanusalis Wellness Care</div>
        </div>
      </div>
      <div className='d-flex align-items-center mt-4'>
        <p className='font-13 text-dark pb-0 mb-0 font-semibold me-2'>Quantity: </p>
        {/* <Field
          type="text"
          value="1"
          validationRules={['notEmpty']}
          className="qty"
          name="qty"
          placeholder={_('Qty')}
          formId="productForm"
        /> */}
        <Select
            className="form-control qty"
            name="qty"
            options={[
              { value: 1, text: '1' },
              { value: 2, text: '2' },
              { value: 3, text: '3' },
            ]}
            validationRules={['notEmpty']}
            placeholder="0"
            formId="productForm"
          />
      </div>
      {error && <div className="text-critical mt-1">{error}</div>}
      <div className="mt-1 add-card">
        {stockAvaibility === true && (
          <Button
            title={_('ADD TO CART')}
            outline
            isLoading={loading}
            onAction={() => {
              document.getElementById('productForm').dispatchEvent(
                new Event('submit', { cancelable: true, bubbles: true })
              );
            }}
          />
        )}
        {stockAvaibility === false && (
          <Button title={_('SOLD OUT')} onAction={() => { }} />
        )}
      </div>
    </div>
  );
}

AddToCart.propTypes = {
  error: PropTypes.string,
  loading: PropTypes.bool.isRequired,
  stockAvaibility: PropTypes.bool.isRequired
};

AddToCart.defaultProps = {
  error: undefined
};

export default function ProductForm({ product, action }) {
  const [loading, setLoading] = useState(false);
  const [toastId, setToastId] = useState();
  const [error, setError] = useState();
  const appContext = useAppState();
  const { setData } = useAppDispatch();

  const onSuccess = (response) => {
    if (!response.error) {
      setData(
        produce(appContext, (draff) => {
          draff.cart = appContext.cart || {};
          draff.cart.totalQty = response.data.count;
          draff.cart.uuid = response.data.cartId;
        })
      );
      setToastId(
        toast(
          <ToastMessage
            thumbnail={response.data.item.thumbnail}
            name={product.name}
            qty={response.data.item.qty}
            count={response.data.count}
            cartUrl="/cart"
            toastId={`${toastId}-${Math.random().toString(36).slice(2)}`}
          />,
          { closeButton: false }
        )
      );
    } else {
      setError(response.error.message);
    }
  };

  return (
    <Form
      id="productForm"
      action={action}
      method="POST"
      submitBtn={false}
      onSuccess={onSuccess}
      onStart={() => setLoading(true)}
      onComplete={() => setLoading(false)}
      onError={(e) => setError(e.message)}
      isJSON
    >
      <input type="hidden" name="sku" value={product.sku} />
      <h4 className="font-24 text-black"> <span className="sale-price fw-medium d-flex align-items-start"><span className='fs-4 lh-1'>₹</span>{product.price.special.value.toFixed(2)}</span> </h4>
      <Area
        id="productSinglePageForm"
        coreComponents={[
          {
            component: { default: AddToCart },
            props: {
              stockAvaibility: product.inventory.isInStock,
              loading,
              error
            },
            sortOrder: 50,
            id: 'productSingleBuyButton'
          }
        ]}
      />
    </Form>
  );
}

ProductForm.propTypes = {
  action: PropTypes.string.isRequired,
  product: PropTypes.shape({
    inventory: PropTypes.shape({
      isInStock: PropTypes.bool.isRequired
    }).isRequired,
    price: PropTypes.shape({
      regular: PropTypes.shape({
        value: PropTypes.number.isRequired,
        text: PropTypes.string.isRequired
      }).isRequired,
      special: PropTypes.shape({
        value: PropTypes.number.isRequired,
        text: PropTypes.string.isRequired
      }).isRequired
    }),
    name: PropTypes.string.isRequired,
    sku: PropTypes.string.isRequired
  }).isRequired
};

export const layout = {
  areaId: 'productPagePrice',
  sortOrder: 40
};

export const query = `
  query Query {
    product(id: getContextValue('productId')) {
      productId
      sku
      name
      price {
        regular {
          value
          currency
        }
        special {
          value
          currency
        }
      }
      gallery {
        thumb
      }
      inventory {
        isInStock
      }
    }
    action:url (routeId: "addMineCartItem")
  }
`;
