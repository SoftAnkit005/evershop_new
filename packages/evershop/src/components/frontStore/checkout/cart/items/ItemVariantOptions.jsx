import PropTypes from 'prop-types';
import React from 'react';

export function ItemVariantOptions({ options = [] }) {
  if (!Array.isArray(options) || !options || options.length === 0) {
    return null;
  }

  return (
    <div className="cart-item-variant-options mt-05">
      <ul className='ps-0'>
        {options.map((o, i) => (
          // eslint-disable-next-line react/no-array-index-key
          <li key={i}>
            <span className="attribute-name font-16 pb-0 text-black">{o.attribute_name}: </span>
            <span className='font-16 pb-0 text-black'>{o.option_text}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

ItemVariantOptions.propTypes = {
  options: PropTypes.arrayOf(
    PropTypes.shape({
      attribute_name: PropTypes.string,
      option_text: PropTypes.string
    })
  )
};

ItemVariantOptions.defaultProps = {
  options: []
};
