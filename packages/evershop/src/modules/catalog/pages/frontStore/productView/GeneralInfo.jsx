import PropTypes from 'prop-types';
import React, { useEffect } from 'react';
import Area from '@components/common/Area';
import './GeneralInfo.scss';
import { Name } from '@components/frontStore/catalog/product/single/Name';
import { Price } from '@components/frontStore/catalog/product/single/Price';
import { Sku } from '@components/frontStore/catalog/product/single/Sku';
import { brand } from '@components/frontStore/catalog/product/single/brand';
import { companydetails } from '@components/frontStore/catalog/product/single/companydetails';
import { video } from '@components/frontStore/catalog/product/single/video';

export default function GeneralInfo({ product, coupons = [] }) {
 
  return (
    <Area
      id="productViewGeneralInfo"
      className="products-wrapper"
      coreComponents={[
        {
          component: { default: Name },
          props: {
            name: product.name
          },
          sortOrder: 10,
          id: 'productSingleName'
        },
        {
          component: { default: Price },
          props: {
            regular: product.price.regular,
            sku: product.sku,
            special: product.price.special,
            amazonLink:product.amazon,
            flipkartLink:product.flipkart,
            coupons:coupons
          },
          sortOrder: 10,
          id: 'productSinglePrice'
        },
        {
          component: { default: Sku },
          props: {
            sku: product.sku
          },
          sortOrder: 20,
          id: 'productSingleSku'
        },
        {
          component: { default: companydetails },
          props: { },
          sortOrder: 20,
          id: 'brand'
        },
        {
          component: { default: brand },
          props: {
            usefor: product.usefor,
            powersource: product.powersource,
            material: product.material,
            itemweight: product.itemweight,
            companydetails: product.companydetails,
            brand: product.brand,
            color: product.color,
            specialfeature: product.specialfeature,
            specificusesforproduct: product.specificusesforproduct,
            productbenefits: product.productbenefits,
            productdimensions: product.productdimensions
          },
          sortOrder: 20,
          id: 'brand'
        },
        // {
        //   component: { default: video },
        //   props: {
        //     video: product.video
        //   },
        //   sortOrder: 20,
        //   id: 'brand'
        // }
      ]}
    />
  );
}

GeneralInfo.propTypes = {
  product: PropTypes.shape({
    name: PropTypes.string.isRequired,
    sku: PropTypes.string.isRequired,
    productId: PropTypes.number.isRequired,
    usefor: PropTypes.string.isRequired,
    powersource: PropTypes.string.isRequired,
    specificusesforproduct: PropTypes.string.isRequired,
    companydetails: PropTypes.string.isRequired,
    video: PropTypes.string.isRequired,
    amazon: PropTypes.string.isRequired,
    flipkart: PropTypes.string.isRequired,
    material: PropTypes.string.isRequired,
    itemweight: PropTypes.string.isRequired,
    brand: PropTypes.string.isRequired,
    color: PropTypes.string.isRequired,
    specialfeature: PropTypes.string.isRequired,
    productbenefits: PropTypes.string.isRequired,
    productdimensions: PropTypes.string.isRequired,
    price: PropTypes.shape({
      regular: PropTypes.shape({
        value: PropTypes.number.isRequired,
        text: PropTypes.string.isRequired
      }),
      special: PropTypes.shape({
        value: PropTypes.number.isRequired,
        text: PropTypes.string.isRequired
      })
    })
  }).isRequired
};

export const layout = {
  areaId: 'productPageMiddleRight',
  sortOrder: 10
};

export const query = `
  query Query {
    product (id: getContextValue('productId')) {
      name
      productId
      sku
      usefor
      specificusesforproduct
      productbenefits
      material
      itemweight
      brand
      color
      specialfeature
      productdimensions
      companydetails
      video
      amazon
      flipkart
      price {
        regular {
          value
          text
        }
        special {
          value
          text
        }
      }
    }
    coupons{
      items{
        coupon_id
        coupon
        description
        discount_type
        coupon_heading
        start_date
        end_date
        target_products
      }
    }
  }`;
