/* eslint-disable jsx-a11y/label-has-associated-control */
/* eslint-disable jsx-a11y/iframe-has-title */
import React from 'react';
import "../../../../Styles/Styles.scss";
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

export default function ContactUs() {



    return (
        <section className='contact'>
            <div className='container'>
                <div className='row'>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-6'>
                        <div className='contact-details'>
                            <h4 className="font-20">about bhanusali wellness care</h4>
                            <p className="font-16">In fact, it s kind of like herding cats. Demands change, deadlines shift, and projects always seem to be in a constant state of flux. If you want to make sure your clients feel appreciated through the daily ups and downs, and that you stay at the top of their list, we’ve got the perfect solution: the gift of massage Accessories.</p>
                            <hr />
                            <h4 className="font-20">contact us</h4>
                            <div className='row'>
                                <div className='col-12 col-sm-6 col-md-6 col-lg-6'>
                                    <div className='contact-info'>
                                        <div className='contact-icon'>
                                            <img src='Assets/Images/call.svg' alt='Call' />
                                        </div>
                                        <p className="font-16 text-dark mt-2"><b>+91 9825735973</b></p>
                                    </div>
                                </div>
                                <div className='col-12 col-sm-6 col-md-6 col-lg-6'>
                                    <div className='contact-info'>
                                        <div className='contact-icon'>
                                            <img src='Assets/Images/gmail.svg' alt='Gmail' />
                                        </div>
                                        <p className="font-16 text-dark mt-2"><b>info@DrBWC.com</b></p>
                                    </div>
                                </div>
                                <div className='col-12 col-sm-6 col-md-6 col-lg-6'>
                                    <div className='contact-info'>
                                        <div className='contact-icon'>
                                            <img src='Assets/Images/address.svg' alt='Address' />
                                        </div>
                                        <p className="font-16 text-dark mt-2"><b>VIP road, vesu surat, gujarat - 395007, India</b></p>
                                    </div>
                                </div>
                                <div className='col-12 col-sm-6 col-md-6 col-lg-6'>
                                    <div className='contact-info'>
                                        <div className='contact-icon'>
                                            <img src='Assets/Images/shipping.svg' alt='Free shipping' />
                                        </div>
                                        <p className="font-16 text-dark mt-2"><b>Free shipping</b></p>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <p className="font-16 pb-0">Do you have questions about how we can help your company?</p>
                            <p className="font-16 text-dark pb-0"><b>Send us an email and we ll get in touch shortly.</b></p>
                        </div>
                    </div>
                    <div className='col-12 col-sm-12 col-md-12 col-lg-6'>
                        <div className='contact-form mt-5 mt-md-5 mt-lg-0'>
                            <h4 className="font-20">send us an email</h4>
                            <div className='row'>
                                <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                                    <div className='form-group mb-4'>
                                        <label className="font-16 pb-1 text-body">Your Name</label>
                                        <input type='text' className='form-control' />
                                    </div>
                                </div>
                                <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                                    <div className='form-group mb-4'>
                                        <label className="font-16 pb-1 text-body">Your Email</label>
                                        <input type='email' className='form-control' />
                                    </div>
                                </div>
                                <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                                    <div className='form-group mb-4'>
                                        <label className="font-16 pb-1 text-body">Phone Number</label>
                                        <input type='number' className='form-control' />
                                    </div>
                                </div>
                                <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
                                    <div className='form-group mb-4'>
                                        <label className="font-16 pb-1 text-body">Company</label>
                                        <input type='text' className='form-control' />
                                    </div>
                                </div>
                                <div className='col-12'>
                                    <div className='form-group mb-4'>
                                        <label className="font-16 pb-1 text-body">Your Message</label>
                                        <textarea type='text' className='form-control' required rows='5' />
                                    </div>
                                </div>
                                <div className='col-12'>
                                    <div className='form-group'>
                                        <a href="#" className="btn btn-brown">Send Mail</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className='col-12'>
                        <div className='google-map'>
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3721.3176925763364!2d72.7690224760006!3d21.13975168395564!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be0520158979483%3A0x5443480ea5b2a4be!2sVIP%20Road%2C%20Vesu%2C%20Surat%2C%20Gujarat!5e0!3m2!1sen!2sin!4v1714726750319!5m2!1sen!2sin" width="100%" height="550" allowFullScreen="" loading="lazy" referrerPolicy="no-referrer-when-downgrade" />
                        </div>
                    </div>
                </div>

            </div>
        </section>
    );
}

export const layout = {
    areaId: 'content',
    sortOrder: 10
};
