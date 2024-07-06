import PropTypes from 'prop-types';
import React from 'react';

function Name({ name, url }) {
  return (
    <div className="pt-2">
      <a href={url} className='text-decoration-none'>
        <span className='font-16 text-dark'>{name}</span>
      </a>
      <div className="font-14 mt-0 pb-0">Foot & Leg Massager</div>
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
