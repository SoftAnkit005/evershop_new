import PropTypes from 'prop-types';
import React from 'react';
import { IoLockClosedSharp } from 'react-icons/io5';

function Attributes({ product: { attributes } }) {
  if (!attributes.length) {
    return null;
  }

  return (
    <div className="pb-0">
      <ul className="list-disc list-inside border p-3 rounded-4 mt-4">
        {attributes.map((attribute) => (
          <li key={attribute.attributeCode} className='d-flex'>
            <strong className='font-12 p-0 text-black'>{attribute.attributeName}: </strong>{' '}
            <span className='font-12 p-0 text-muted ms-3'>{attribute.optionText}</span>
          </li>
        ))}
      </ul>
      <button className='text-cadetblue font-12 d-flex align-items-center fs-5' ><IoLockClosedSharp  className='me-2 text-muted fs-2'/> Secure Transaction</button>
      <button type="button" class="btn btn-light fs-4 w-100 text-center border rounded-2 py-2 mt-4">Add to Wish List</button>
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
