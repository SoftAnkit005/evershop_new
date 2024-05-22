
import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import './../../../../Styles/Styles.scss';


export default function FeaturedAccreditation() {   

 
  return (
    <section className='accreditation'>
        <div className='container'>
            <div className='text-center'>
                <h3 className='products-subtitle-black'>Our Accreditation</h3>
                <p className='products-details-black'>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
            </div>
            <div className='accreditation-item'>
                <div className='accreditation-image'>
                    <img src='Assets/Images/accreditation_one.png' alt='Accreditation Image' />
                </div>
                <div className='accreditation-image'>
                    <img src='Assets/Images/accreditation_two.png' alt='Accreditation Image' />
                </div>
                <div className='accreditation-image'>
                    <img src='Assets/Images/accreditation_three.png' alt='Accreditation Image' />
                </div>
                <div className='accreditation-image'>
                    <img src='Assets/Images/accreditation_four.png' alt='Accreditation Image' />
                </div>
                <div className='accreditation-image'>
                    <img src='Assets/Images/accreditation_five.png' alt='Accreditation Image' />
                </div>
            </div>
        </div>
    </section>
  );
}
export const layout = {
  areaId: 'content',
  sortOrder: 16
};