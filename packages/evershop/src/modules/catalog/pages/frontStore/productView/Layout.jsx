import React from 'react';
import Area from '@components/common/Area';

export default function ProductPageLayout() {

  return (
    <div className="product-detail my-5 mb-0 py-5">
      <Area id="productPageTop" className="product-page-top" />
      <div className="product-page-middle">
        <div className='container'>
          <div className='row'>
            <div className="col-12 col-sm-12 col-lg-5 productImages">
              <Area id="productPageMiddleLeft" />
            </div>
            <div className='col-12 col-sm-12 col-lg-4 productDescription'>
              <Area id="productPageMiddleRight" />
            </div>
            <div className='col-12 col-sm-12 col-lg-3 productPrice'>
              <Area id="productPagePrice" className='spPrice' />
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
