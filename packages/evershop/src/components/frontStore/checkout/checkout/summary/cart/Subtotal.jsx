import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Subtotal({ count, total }) {
  return (
    <div className="summary-row border-bottom">
      <span className='font-16 text-black pb-0 fw-medium'>{_('Sub total')}</span>
      <div>
        <div className='font-16 text-black pb-0 fw-medium'>{_('${count} items', { count })}</div>
        <div className='font-16 text-black pb-0 fw-medium'>{total}</div>
      </div>
    </div>
  );
}

Subtotal.propTypes = {
  count: PropTypes.number.isRequired,
  total: PropTypes.string.isRequired
};
