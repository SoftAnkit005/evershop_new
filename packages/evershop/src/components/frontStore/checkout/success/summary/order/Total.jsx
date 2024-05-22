import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Total({ total, taxAmount, displayCheckoutPriceIncludeTax }) {
  return (
    <div className="d-flex align-items-center justify-content-between border-top">
      {(displayCheckoutPriceIncludeTax && (
        <div className='w-100'>
          <div className='font-16 pb-0'>
            <div className="font-bold">
              <span>{_('Total')}</span>
            </div>
            <div>
              <span className="italic fw-medium">
                ({_('Inclusive of tax ${taxAmount}', { taxAmount })})
              </span>
            </div>
          </div>
        </div>
      )) || <span className="self-center font-bold">{_('Total')}</span>}
      <div className='w-100'>
        <div className="font-20 text-end">{total}</div>
      </div>
    </div>
  );
}

Total.propTypes = {
  total: PropTypes.number.isRequired,
  taxAmount: PropTypes.number.isRequired,
  displayCheckoutPriceIncludeTax: PropTypes.bool.isRequired
};
