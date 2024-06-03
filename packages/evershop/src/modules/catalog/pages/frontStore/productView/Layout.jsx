import React from 'react';
import Area from '@components/common/Area';

export default function ProductPageLayout() {

  return (
    <div className="product-detail mt-5 mb-0 pt-5">
      <Area id="productPageTop" className="product-page-top" />
      <div className="product-page-middle">
        <div className='container'>
          <div className='row'>
            <div className="col-12 col-sm-12 col-md-6 col-lg-4">
              <Area id="productPageMiddleLeft" />
            </div>
            <div className='col-12 col-sm-12 col-md-6 col-lg-5'>
              <Area id="productPageMiddleRight" />

            </div>
            <div className='col-12 col-sm-12 col-md-6 col-lg-3'>
              <Area id="productPagePrice" />
            </div>
          </div>
        </div>

      </div>
      <Area id="productPageBottom" className="product-page-top" />
    </div>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
