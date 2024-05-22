import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Discount({ discount, code }) {
  if (!discount) {
    return null;
  }

  return (
    <div className="summary-row border-bottom">
      <span className='font-16 text-black pb-0 fw-medium'>{_('Discount')}</span>
      <div>
        <div className='font-16 text-black pb-0 fw-medium'>{code}</div>
        <div className='font-16 text-black pb-0 fw-medium'>{discount}</div>
      </div>
    </div>
  );
}

Discount.propTypes = {
  code: PropTypes.string,
  discount: PropTypes.string
};

Discount.defaultProps = {
  code: undefined,
  discount: undefined
};
