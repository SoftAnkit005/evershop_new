import PropTypes from 'prop-types';
import React from 'react';

export function Name({ name }) {
  return (
    <>
      <h1 className="font-30 p-0">{name}</h1>
      <p className='font-12 d-flex align-items-center text-cadetblue'>Brand: DR BWC</p>

      <hr />
    </>
  )
}

Name.propTypes = {
  name: PropTypes.string.isRequired
};
