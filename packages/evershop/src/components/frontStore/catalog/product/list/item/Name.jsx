import PropTypes from 'prop-types';
import React from 'react';

function Name({ name, url }) {
  return (
    <div className="ps-4">
      <a href={url}>
        <span>{name}</span>
      </a>
    </div>
  );
}

Name.propTypes = {
  url: PropTypes.string,
  name: PropTypes.string
};

Name.defaultProps = {
  url: '',
  name: ''
};

export { Name };
