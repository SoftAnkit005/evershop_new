import React from 'react';
import { IoLockClosedSharp } from 'react-icons/io5';

function SecureTransaction() {
  return (
    <>
        <button className='text-cadetblue font-12 d-flex align-items-center fs-5' ><IoLockClosedSharp  className='me-2 text-muted fs-2'/> Secure Transaction</button>
    </>
  )
}

export const layout = {
    areaId: 'secureTransaction',
    sortOrder: 0
};
  

export default SecureTransaction