import React from 'react';
import Area from '@components/common/Area';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import './../../../../Styles/Styles.scss';

export default function CategoryView() {
  return (
    <div className="container">
      <div className='row'>
        <Area id="leftColumn" className="col-12 col-sm-12 col-md-3 col-lg-3" />
        <Area id="rightColumn" className="col-12 col-sm-12 col-md-9 col-lg-9" />
      </div>
    </div>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
