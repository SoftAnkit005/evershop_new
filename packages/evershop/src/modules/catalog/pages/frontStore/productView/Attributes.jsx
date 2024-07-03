import PropTypes from 'prop-types';
import React from 'react';

function Attributes({ product: { attributes } }) {
  if (!attributes.length) {
    return null;
  }

  return (
    <div className="pb-0">
      <ul className="list-disc list-inside border p-4 mb-5 rounded-4">
        {attributes.map((attribute) => (
          <li key={attribute.attributeCode} className='d-flex'>
            <strong className='font-18 text-black'>{attribute.attributeName}: </strong>{' '}
            <span className='font-18 text-muted ms-3'>{attribute.optionText}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

Attributes.propTypes = {
  product: PropTypes.shape({
    attributes: PropTypes.arrayOf(
      PropTypes.shape({
        attributeName: PropTypes.string.isRequired,
        attributeCode: PropTypes.string.isRequired,
        optionText: PropTypes.string.isRequired
      })
    ).isRequired
  }).isRequired
};

export const query = `
  query Query {
    product (id: getContextValue('productId')) {
      attributes: attributeIndex {
        attributeName
        attributeCode
        optionText
      }
    }
  }
`;

export const layout = {
  areaId: 'productPagePrice',
  sortOrder: 45
};

export default Attributes;
