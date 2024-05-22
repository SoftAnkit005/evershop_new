import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Discount({ discount, code }) {
  if (!discount) {
    return null;
  }

  return (
    <div className="summary-row">
      <span className='font-16 pb-0 text-black'>{_('Discount')}</span>
      <div>
        <div className='font-16 pb-0 text-black'>{code}</div>
        <div className='font-16 pb-0 text-black'>{discount}</div>
      </div>
    </div>
  );
}

Discount.propTypes = {
  code: PropTypes.string,
  discount: PropTypes.number
};

Discount.defaultProps = {
  code: undefined,
  discount: undefined
};
