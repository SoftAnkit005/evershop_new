import React from 'react'
import { GoArrowRight } from "react-icons/go";

export default function NewHomeProductList({ products = [] }) {

  return (
    <div className='row gap-4 gap-xl-2 new-home-product-list'>
      {products.map((item) =>
        <div className='col'>
          <a className='text-decoration-none' href={item.url}>
            <div className='p-4 rounded-4 new-home-product-bg'>
              <img src={item.image.url} className='rounded' alt="" />
            </div>
            <p className="font-14 font-medium mt-4 text-center text-dark text-uppercase">{item.name}</p>
            <p className="font-14 text-center text-dark text-uppercase">{item.productDetails}</p>
          </a>
        </div>
      )}
      <div className='text-center'>
        <a href='products' className='btn-white d-flex justify-content-center pt-5'> View All Products <GoArrowRight className='ms-1' /></a>
      </div>
    </div>
  )
}