import React from 'react';
import Area from '@components/common/Area';

export default function ProductPageLayout() {

  return (
    <div className="product-detail my-5 mb-0 py-5">
      <Area id="productPageTop" className="product-page-top" />
      <div className="product-page-middle">
        <div className='container'>
          <div className='row'>
            <div className="col-12 col-sm-12 col-lg-5 col-xxl-6 productImages">
              <Area id="productPageMiddleLeft" />
            </div>
            <div className='col-12 col-sm-12 col-lg-4 col-xxl-4 productDescription'>
              <Area id="productPageMiddleRight" />
            </div>
            <div className='col-12 col-sm-12 col-lg-3 col-xxl-2 productPrice'>
              <Area id="productPagePrice" className='spPrice' />
            </div>
          </div>
          <hr />
          <h4 className="font-20 p-0 text-brawn">product description</h4>
          <Area id="productPageDetails" />
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
