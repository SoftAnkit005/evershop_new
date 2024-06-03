import PropTypes from 'prop-types';
import React from 'react';

// eslint-disable-next-line no-unused-vars
export function Sku({ sku }) {
  return (
    <div className="font-18 text-muted pb-0">
      <span />
      <span />
    </div>
  );
}

Sku.propTypes = {
  sku: PropTypes.string.isRequired
};
