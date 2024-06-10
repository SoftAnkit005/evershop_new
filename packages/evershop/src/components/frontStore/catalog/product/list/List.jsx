import PropTypes from 'prop-types';
import React from 'react';
import { Name } from '@components/frontStore/catalog/product/list/item/Name';
import { Thumbnail } from '@components/frontStore/catalog/product/list/item/Thumbnail';
import { Price } from '@components/frontStore/catalog/product/list/item/Price';
import Area from '@components/common/Area';
import { get } from '@evershop/evershop/src/lib/util/get';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export default function ProductList({ products = [], countPerRow = 3 }) {
  if (products.length === 0) {
    return (
      <div className="product-list">
        <div>
          <img src='Assets/Images/no_data.svg' alt='No data' className='mb-5 mt-5 m-auto' />
        </div>
        <div className="text-center font-16 text-black">{_('There is no product to display')}</div>
      </div>
    );
  }

  let className;
  switch (countPerRow) {
    case 3:
      className = 'row wishlist-section';
      break;
    case 4:
      className = 'row wishlist-section';
      break;
    case 5:
      className = 'row wishlist-section';
      break;
    default:
      className = 'row wishlist-section';
  }


  return (
    <div className={className}>
      {products.map((p) => (
        <Area
          id="productListingItem"
          className="card col-12 col-sm-6 col-md-6 col-lg-6 col-xl-4 col-xxl-4 mb-5"
          product={p}
          key={p.productId}
          coreComponents={[
            {
              component: { default: Thumbnail },
              props: { url: p.url, imageUrl: get(p, 'image.url'), alt: p.name },
              sortOrder: 10,
              id: 'thumbnail'
            },
            {
              component: { default: Name },
              props: { name: p.name, url: p.url, id: p.productId },
              sortOrder: 20,
              id: 'name'
            },
            {
              component: { default: Price },
              props: { ...p.price },
              sortOrder: 30,
              id: 'price'
            }
          ]}
        />
      ))}
    </div>
  );
}

ProductList.propTypes = {
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
  ).isRequired,
  countPerRow: PropTypes.number.isRequired
};
