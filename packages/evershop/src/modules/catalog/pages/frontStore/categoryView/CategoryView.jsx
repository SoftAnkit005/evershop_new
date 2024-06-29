import React from 'react';
import Area from '@components/common/Area';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../../../../Styles/Styles.scss";

export default function CategoryView() {
  return (
    <div className='row product-container'>
      <Area id="leftColumn" className="col-12 col-sm-12 col-md-3 col-lg-2 pe-5 pb-5" />
      <Area id="rightColumn" className="col-12 col-sm-12 col-md-9 col-lg-10 products-rightColumn" />
    </div>
    /* <div className="container">
    </div> */
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
