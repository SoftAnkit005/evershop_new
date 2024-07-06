import PropTypes from 'prop-types';
import React from 'react';
import Button from '@components/common/form/Button';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import { FaPlus } from 'react-icons/fa6';

function AddToCart({ stockAvaibility, loading = false }) {
  return (
    <div className="add-card">
      {stockAvaibility === true && (
        <>
          <p className='in-stock'>In Stock</p>
          <Button
            title={_([<FaPlus className='position-static me-2' style={{ transform: 'inherit' }} />, 'ADD TO CART'])}
            outline
            isLoading={loading}
            onAction={() => {
              document
                .getElementById('productForm')
                .dispatchEvent(
                  new Event('submit', { cancelable: true, bubbles: true })
                );
            }}
          />
        </>
      )}
      {stockAvaibility === false && (
        <>
          <p className='out-of-stock'>Out Of Stock</p>
          <Button title={_('SOLD OUT')} onAction={() => { }} />
        </>
      )}
    </div>
  );
}

AddToCart.propTypes = {
  loading: PropTypes.bool.isRequired,
  stockAvaibility: PropTypes.bool.isRequired
};

export { AddToCart };
