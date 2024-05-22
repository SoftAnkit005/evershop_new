import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Shipping({ method, cost }) {
  if (!method) {
    return null;
  }

  return (
    <div className="summary-row">
      <span className='font-16 pb-0 text-black'>{_('Shipping')}</span>
      <div>
        <div className='font-16 pb-0 text-black'>{method}</div>
        <div className='font-16 pb-0 text-black'>{cost}</div>
      </div>
    </div>
  );
}

Shipping.propTypes = {
  cost: PropTypes.string,
  method: PropTypes.string
};

Shipping.defaultProps = {
  cost: undefined,
  method: undefined
};
