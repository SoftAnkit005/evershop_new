import React from 'react';
import { useAppState } from '@components/common/context/app';
import Button from '@components/common/form/Button';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

const { get } = require('@evershop/evershop/src/lib/util/get');

export function Empty() {
  const items = get(useAppState(), 'cart.items', []);
  if (items.length > 0) {
    return null;
  }
  return (
    <div className="empty-shopping-cart w-100 mt-5 mb-5">
      <div>
        <div className="text-center">
          <h2>{_('Shopping cart')}</h2>
        </div>
        <div className="mt-2 text-center mb-4">
          <p className='font-16'>{_('Your cart is empty!')}</p>
        </div>
        <div className='w-100 text-center mt-4'>
          <Button
            url="/"
            className="d-block"
            title={_('CONTINUE SHOPPING')}
          />
        </div>

      </div>
    </div>
  );
}
