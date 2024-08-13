import axios from 'axios';
import PropTypes from 'prop-types';
import React from 'react';
import { IoLockClosedSharp } from 'react-icons/io5';
import { toast } from 'react-toastify';

function AddToWishList({product, account}) {
  
  const addProduct = async () => {
    const userId = account?.customerId.toString();
    const baseUrl = `${window.location.protocol}//${window.location.host}`;
    const apiUrl = `${baseUrl}/api/wishlistdata`;

    try {
      const response = await axios.post(
        apiUrl,
        {
          user_id: userId,
          product_id: product.productId
        },
        {
          headers: {
            "Content-Type": "application/json"
          }
        }
      );
      if (response.status === 200) {
        toast("Added to wishlist", { autoClose: 2000 });
      } else {
        toast("Failed to update wishlist", { autoClose: 2000 });
      }
    } catch (error) {
      toast("An error occurred while updating the wishlist", {
        autoClose: 2000
      });
    }
  }

  const handleClick = () => {
    const checkProduct = account.wishlistedProducts.items.filter((item) => item === product.productId);
    
    if (!account) {
      toast("Please log in to add items to your wishlist", {
        autoClose: 2000
      });
      return;
    }

    if(checkProduct.length === 0){
      addProduct();
      setTimeout(() => {
        window.location.reload();
      }, 300);
    }else{
      toast("Product is already in wishlist !", { autoClose: 2000 });
    }

    // if(account.wishlistedProducts.items.length !== 0 ){
    //   account.wishlistedProducts.items.map((item) => {
    //     if(item !== product.productId){
    //       console.log('addProduct()');
    //     }else{
    //       console.log('Product is already in wishlist');
    //     }
    //   })
    // }else {
    //   addProduct();
    //   setTimeout(() => {
    //     window.location.reload();
    //   }, 300);
    // }
  };

  // console.log(account.wishlistedProducts.items);

    return (
      <>
        <div className="pb-0">
          <button className='text-cadetblue font-12 d-flex align-items-center fs-5' ><IoLockClosedSharp  className='me-2 text-muted fs-2'/> Secure Transaction</button>
          <button type="button" class="btn btn-light fs-4 w-100 text-center border rounded-2 py-2 mt-4" onClick={handleClick}>Add to Wish List</button>
        </div>
        <div className='gst-section mt-5'>
          <div class="font-12 text-dark mt-2"><span class="font-12 text-black font-semibold">Save upto 12%</span> with business pricing and GST input tax credit.</div>
          <div className='d-flex align-items-center mt-2'>
            <input className='border-grey text-dark rounded-4' type="text" placeholder="GST number" />
            <button type="button" class="btn btn-light fs-4 ms-2 text-center border rounded-pill py-2">Submit</button>
          </div>
        </div>
      </>
  );
}

export const layout = {
  areaId: 'productPagePrice',
  sortOrder: 47
};

export default AddToWishList;

AddToWishList.propTypes = {
  account: PropTypes.shape({
    customerId: PropTypes.number,
    fullName: PropTypes.string.isRequired,
    email: PropTypes.string.isRequired,
    wishlistedProducts: PropTypes.shape({
      items: PropTypes.arrayOf(PropTypes.string).isRequired
    }).isRequired
  }).isRequired,

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
    account: currentCustomer {
      customerId
      fullName
      email
      wishlistedProducts
    }
  }`;