/* eslint-disable no-console */
import React from 'react';

export default function Grid() {

  const TagSubmit = () => {
    console.log('Hello')
  }

  return (
    <div className="grid grid-cols-4 gap-1">
      <div className="card shadow p-2">
        <div className="form-field-container">
          <div className="form-group mb-3">
            <p className='pb-1'>Id</p>
            <input type="text" name="name" placeholder="Id" className="form-control" />
          </div>
          <div className="form-group mb-3">
            <p className='pb-1'>Name</p>
            <input type="text" name="name" placeholder="Name" className="form-control" />
          </div>
          <div className="form-group mb-3">
            <p className='pb-1'>Product Id</p>
            <input type="text" name="name" placeholder="Product Id" className="form-control" />
          </div>
          <div className='mt-2'>
            <button type="button" className="btn-brown w-100 mt-4 primary btn-white" onClick={TagSubmit}><span>Save</span></button></div>
        </div>
      </div>
    </div>
  );
}
export const layout = {
  areaId: 'content',
  sortOrder: 15
};

