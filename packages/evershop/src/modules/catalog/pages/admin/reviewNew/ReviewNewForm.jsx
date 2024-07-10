/* eslint-disable no-console */
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { Form } from '@components/common/form/Form';

function Grid({ action }) {
  const [name, setName] = useState('');
  const [view, setReview] = useState('');
  const [error, setError] = useState(null);
  const [isLoading, setisLoading] = useState(false)

  const onSuccess = async (event) => {
    setisLoading(true);
    event.preventDefault(); // Prevent default form submission
    try {
      const result = await fetch("https://drbwc.com/api/reviewdata", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          "name": name,
          "view": view
        })
      });

      const data = await result.json();

      if (data.length !== 0) {
        window.location.reload();
        setisLoading(false);
      } else {
        setError(data.message);
      }

    } catch (error) {
      setError('An unexpected error occurred.');
    }
  };


  return (
    <div className="grid grid-cols-4 gap-1">
      <div className="card shadow p-2">
        {error && <div className='error'>{error}</div>}
        <form id="reviewForm" onSubmit={onSuccess} >
          <div className="form-field-container">            
            <div className="form-group mb-3">
              <p className="pb-1">Name</p>
              <input
                type="text"
                name="name"
                placeholder="Name"
                className="form-control"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </div>
            
            <div className="form-group mb-3">
              <p className="pb-1">Review</p>
              <textarea
                name="view"
                placeholder="Review"
                className="form-control"
                value={view}
                onChange={(e) => setReview(e.target.value)}
              />
            </div>
            <button type="submit" className="btn-brown mt-4 primary btn-white">
              {(isLoading === true)?
                <svg style={{ background: 'rgb(255, 255, 255, 0)', display: 'block', shapeRendering: 'auto' }} width="2rem" height="2rem" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid" > <circle cx="50" cy="50" fill="none" stroke="#fff" strokeWidth="10" r="43" strokeDasharray="202.63272615654165 69.54424205218055" > <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" values="0 50 50;360 50 50" keyTimes="0;1" /> </circle> </svg>
                  :
                <span>Submit</span>
              }
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// No longer marking `condition` as required, since it's managed within the component
Grid.propTypes = {
  action: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 15
};

export const query = `
  query Query {
    action: url(routeId: "reviewGrid")
  }
`;

export default Grid;
