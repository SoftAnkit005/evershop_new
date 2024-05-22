import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Subtotal({ count, total }) {
  return (
    <div className="summary-row">
      <span className='font-16 pb-0 text-black'>{_('Sub total')}</span>
      <div>
        <div className='font-16 pb-0 text-black'>{_('${count} items', { count })}</div>
        <div className='font-16 pb-0 text-black'>{total}</div>
      </div>
    </div>
  );
}

Subtotal.propTypes = {
  count: PropTypes.number.isRequired,
  total: PropTypes.string.isRequired
};
