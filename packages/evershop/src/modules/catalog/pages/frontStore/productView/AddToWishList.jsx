import PropTypes from 'prop-types';
import React from 'react';
import { IoLockClosedSharp } from 'react-icons/io5';

function AddToWishList() {
    return (
    <div className="pb-0">
      <button className='text-cadetblue font-12 d-flex align-items-center fs-5' ><IoLockClosedSharp  className='me-2 text-muted fs-2'/> Secure Transaction</button>
      <button type="button" class="btn btn-light fs-4 w-100 text-center border rounded-2 py-2 mt-4">Add to Wish List</button>
    </div>
  );
}

export const layout = {
  areaId: 'productPagePrice',
  sortOrder: 47
};

export default AddToWishList;
