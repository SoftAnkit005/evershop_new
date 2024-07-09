import React from 'react'
import "../../../../Styles/Styles.scss";

export default function Gallery() {
  return (
    <section className='gallery-page'>
      <div className='container'>
        <div className='row'>
          <div className='text-center'>
            <h3 className='font-30'>Gallery</h3>
            <p className='font-14 text-theme-grey mb-3'>Bhanusali Wellness is a proficient company that provides state-of-the-art massages accessories for its users.</p>
          </div>
          <div className='row mt-4'>
            <div className='col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 mb-5'>
              <div className='gallery-box'>
                <img src='Assets/Images/products_one.png' alt='gallery' />
              </div>
            </div>
            <div className='col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 mb-5'>
              <div className='gallery-box'>
                <img src='Assets/Images/products_two.png' alt='gallery' />
              </div>
            </div>
            <div className='col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 mb-5'>
              <div className='gallery-box'>
                <img src='Assets/Images/products_three.png' alt='gallery' />
              </div>
            </div>
            <div className='col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 mb-5'>
              <div className='gallery-box'>
                <img src='Assets/Images/products_four.png' alt='gallery' />
              </div>
            </div>
            <div className='col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 mb-5'>
              <div className='gallery-box'>
                <img src='Assets/Images/products_five.png' alt='gallery' />
              </div>
            </div>
            <div className='col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 mb-5'>
              <div className='gallery-box'>
                <img src='Assets/Images/products_six.png' alt='gallery' />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}


export const layout = {
  areaId: 'content',
  sortOrder: 10
};


