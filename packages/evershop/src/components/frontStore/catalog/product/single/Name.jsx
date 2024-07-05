import PropTypes from 'prop-types';
import React from 'react';

export function Name({ name }) {
  return (
    <>
      <h1 className="font-30 p-0">{name}</h1>
      <p className='font-14 mt-2 pb-0'>Foot, Calf & Leg Massager, with Vibration & Heat, 3 Massage Levels, 4 motors, Corded Electric.</p>
      <hr />
    </>
  )
}

Name.propTypes = {
  name: PropTypes.string.isRequired
};
