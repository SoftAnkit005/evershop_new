import PropTypes from 'prop-types';
import React from 'react';
import { get } from '@evershop/evershop/src/lib/util/get';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export default function HomeProductList({ products = [] }) {

  if (products.length === 0) {
    return (
      <div className="product-list">
        <div className="text-center font-16 text-black">{_('There is no product to display')}</div>
      </div>
    );
  }

  return (
    <>
      {products.map((p, index) => (
        <div className='products-list' key={p.productId}>
          <div className='container'>
            <div className='row align-items-center'>
              {index % 2 === 0 ? (
                <>
                  <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                    <div className='products-info'>
                      <h1 className='products-title-white'>Auto Wellness Program</h1>
                      <h2 className='doc-name-white'>DR.BWC</h2>
                      <h3 className='products-subtitle-white'>{p.name}</h3>
                      <p className='font-16 text-white'>{p.companydetails}</p>
                      <div className='mt-3'>
                        <a href='products' className='btn-white'>View All Products</a>
                      </div>
                    </div>
                  </div>
                  <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                    <div className='products-img'>
                      <img src={get(p, 'image.url')} alt={p.name} className='w-100' />
                    </div>
                  </div>
                </>
              ) : (
                <>
                  <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                    <div className='products-img'>
                      <img src={get(p, 'image.url')} alt={p.name} />
                    </div>
                  </div>
                  <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                    <div className='products-info'>
                      <h1 className='products-title-white'>Auto Wellness Program</h1>
                      <h2 className='doc-name-white'>DR.BWC</h2>
                      <h3 className='products-subtitle-white'>{p.name}</h3>
                      <p className='font-16 text-white'>{p.companydetails}</p>
                      <div className=''>
                        <a href='products' className='btn-white'>View All Products</a>
                      </div>
                    </div>
                  </div>
                </>
              )}

            </div>
          </div>
        </div>
      ))}
    </>
  );
}

HomeProductList.propTypes = {
  products: PropTypes.arrayOf(
    PropTypes.shape({
      name: PropTypes.string,
      sku: PropTypes.string,
      productId: PropTypes.number,
      url: PropTypes.string,
      price: PropTypes.shape({
        regular: PropTypes.shape({
          value: PropTypes.number,
          text: PropTypes.string
        }),
        special: PropTypes.shape({
          value: PropTypes.number,
          text: PropTypes.string
        })
      }),
      image: PropTypes.shape({
        alt: PropTypes.string,
        listing: PropTypes.string
      })
    })
  ).isRequired
};
