import React from 'react';
import PropTypes from 'prop-types';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export function Total({ total, taxAmount, displayCheckoutPriceIncludeTax }) {
  return (
    <ul className='list-unstyled d-flex align-items-center justify-content-between'>
            <li className='font-18 text-black mb-0'>
            {(displayCheckoutPriceIncludeTax && (
              <div>
                <div>
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
            </li>
            <li className='font-18 text-black mb-0'>{total}</li>
        </ul>

  );
}

Total.propTypes = {
  total: PropTypes.string.isRequired,
  taxAmount: PropTypes.string.isRequired,
  displayCheckoutPriceIncludeTax: PropTypes.bool
};

Total.defaultProps = {
  displayCheckoutPriceIncludeTax: false
};
