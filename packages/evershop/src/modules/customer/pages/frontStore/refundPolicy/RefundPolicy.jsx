import React from 'react';
import "../../../../Styles/Styles.scss";
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

export default function RefundPolicy() {
  return (
    <section className='policy-content'>
      <div className='container'>
        <div className='row'>
          <div className='text-center'>
            <h3 className='font-30'>Refund Policy</h3>
          </div>
          <div className='text-start'>
            <p className='font-16'>Any product kept in its original form of packing, tags, bills and condition will be entitled to be exchanged or returned if the customer deems so. (whatever the reason may be) All items must be exchanged or returned within 01 day of receipt of the good. Any refund will be made directly to customer’s bank account within 4 – 5 working days after the cancellation & pick up of the goods of the order.</p>
          </div>
        </div>
      </div>
    </section>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};


