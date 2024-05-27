import PropTypes from 'prop-types';
import React from 'react';

export function Sku({ sku }) {
  return (
    <div className="font-18 text-muted pb-0">
      <span>Sku</span>
      <span>: {sku}</span>
    </div>
  );
}

Sku.propTypes = {
  sku: PropTypes.string.isRequired
};
