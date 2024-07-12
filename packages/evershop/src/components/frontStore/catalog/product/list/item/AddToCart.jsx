import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import Button from '@components/common/form/Button';
import { FaPlus } from 'react-icons/fa6';
import Area from '@components/common/Area';
import { Form } from '@components/common/form/Form';
import { toast } from 'react-toastify';
import { useAppDispatch, useAppState } from '@components/common/context/app';
import produce from 'immer';
import './AddToCart.scss';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import { Field } from '@components/common/form/Field';

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
      <a className="btn-brown add-cart-popup-button" href={cartUrl}>
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

function AddToCart({ stockAvaibility, product }) {
  const [loading, setLoading] = useState(false);
  const [toastId, setToastId] = useState();
  const [error, setError] = useState();

  const onSuccess = (response) => {
    if (!response.error) {
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
    <div className="add-card">
      <Form
        id={product.productId}
        action="/api/cart/mine/items"
        method="POST"
        submitBtn={false}
        onSuccess={onSuccess}
        onStart={() => setLoading(true)}
        onComplete={() => setLoading(false)}
        onError={(e) => setError(e.message)}
        isJSON
      >
        <input type="hidden" name="sku" value={product.sku} />
        {(stockAvaibility === true) ?
          <>
            <p className='in-stock'>In Stock</p>
            <div className="d-none">
              <Field
                type="text"
                value="1"
                validationRules={['notEmpty']}
                className="qty"
                name="qty"
                placeholder={_('Qty')}
                formId="productForm"
              />
            </div>
            <Button
              title={_([<FaPlus className='position-static me-2' style={{ transform: 'inherit' }} />, 'ADD TO CART'])}
              outline
              isLoading={loading}
              onAction={() => {
                document.getElementById(product.productId).dispatchEvent(
                  new Event('submit', { cancelable: true, bubbles: true })
                );
              }}
            />
          </>
          :
          <>
            <p className='out-of-stock'>Out Of Stock</p>
            <Button title={_('SOLD OUT')} onAction={() => { }} />
          </>
        }
      </Form>
    </div>
  );
}

AddToCart.propTypes = {
  // loading: PropTypes.bool.isRequired,
  stockAvaibility: PropTypes.bool.isRequired,
  product: PropTypes.shape({
    inventory: PropTypes.shape({
      isInStock: PropTypes.bool.isRequired
    }).isRequired,
    name: PropTypes.string.isRequired,
    sku: PropTypes.string.isRequired,
    productId: PropTypes.number.isRequired
  }).isRequired
};

export { AddToCart };




// ProductForm.propTypes = {
//   // action: PropTypes.string.isRequired,
//   product: PropTypes.shape({
//     inventory: PropTypes.shape({
//       isInStock: PropTypes.bool.isRequired
//     }).isRequired,
//     name: PropTypes.string.isRequired,
//     sku: PropTypes.string.isRequired
//   }).isRequired
// };

