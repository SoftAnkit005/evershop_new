import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Tax({ amount }) {
  return (
    <div className="summary-row">
      <span className='font-16 pb-0 text-black'>{_('Tax')}</span>
      <div>
        <div className='font-16 pb-0 text-black'>{amount}</div>
      </div>
    </div>
  );
}

Tax.propTypes = {
  amount: PropTypes.string
};

Tax.defaultProps = {
  amount: undefined
};
