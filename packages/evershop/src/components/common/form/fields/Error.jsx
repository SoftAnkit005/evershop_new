import PropTypes from 'prop-types';
import React from 'react';

function Error({ error }) {
  if (!error) return null;
  return (
    <div className="text-start mt-2 mb-2">      
      <span className="text-warning">{error}</span>
    </div>
  );
}

Error.propTypes = {
  error: PropTypes.string
};

Error.defaultProps = {
  error: undefined
};

export default Error;
