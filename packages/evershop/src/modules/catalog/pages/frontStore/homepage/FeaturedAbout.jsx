
import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../../../../Styles/Styles.scss";

export default function FeaturedAbout() {
    return (
        <section className='about-products p-80'>
            <div className='container row m-auto'>
                <div className='col-lg-6 d-flex flex-column justify-content-center'>
                    <h2 className="products-subtitle-black text-white">Why Dr.BWC?</h2>
                    <p className='products-details-white text-start mb-4'>Our goal is to create the highest degree of luxury with the health benefit of our Massage Equipment in your daily life. Set up in India, Dr.BWC has a prominent background and an enriched experience in the massage machine.</p>
                </div>
                <div className='col-lg-6 row'>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-6'>
                        <div className='products-info align-items-center'>
                            <h1 className='about-title'>01</h1>
                            <p className='products-details-white text-sm-center text-md-start pb-0'>A premium product crafted with highest stature and quality.</p>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-6 mt-5 mt-md-5 mt-lg-0'>
                        <div className='products-info align-items-center'>
                            <h1 className='about-title'>02</h1>
                            <p className='products-details-white text-sm-center text-md-start pb-0'>You receive the highest warranty in the industry with an impeccable proficiency.</p>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-6 mt-5 ms-auto'>
                        <div className='products-info align-items-center'>
                            <h1 className='about-title'>03</h1>
                            <p className='products-details-white text-sm-center text-md-start pb-0'>With the world-class massage chairs that avail you with superior relaxation.</p>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-6 mt-5'>
                        <div className='products-info align-items-center'>
                            <h1 className='about-title'>04</h1>
                            <p className='products-details-white text-sm-center text-md-start pb-0'>We offer the best and efficient after-sale services so that your massage chair is always tending to the ailments.</p>
                        </div>
                    </div>
                </div>
            </div>

        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 14
};