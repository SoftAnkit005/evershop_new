/* eslint-disable react/no-danger */
import { CKEditor } from '@components/common/CKEditor';
import PropTypes from 'prop-types';
import React from 'react';

export default function Description({ product: { description } }) {
  return (
    <div className="border-bottom">
      <div className="product-description col-12 col-lg-10 m-auto">
        <CKEditor content={description} />
      </div>
    </div>
  );
}

Description.propTypes = {
  product: PropTypes.shape({
    description: PropTypes.string
  }).isRequired
};

export const layout = {
  areaId: 'productPageDetails',
  sortOrder: 10
};

export const query = `
  query Query {
    product (id: getContextValue('productId')) {
      description
    }
  }`;
