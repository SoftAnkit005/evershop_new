import React, { useEffect, useState } from 'react';
import Area from '@components/common/Area';
import LoadingBar from '@components/common/LoadingBar';


export default function Layout() {

  const [finalURL, setFinalURL] = useState('');

  useEffect(() => {
    const currentURL = window.location.href;
    const newURL = currentURL.replace(currentURL, '');
    const pathStartIndex = newURL.indexOf('/', 8);
    const newPath = newURL.substring(pathStartIndex);
    const finalURL = window.location.origin + newPath;
    setFinalURL(finalURL);
  }, []);


  return (
    <>
      <LoadingBar />

      <div className='text-center offer-top discount-coupon'>
        <div className='container'>
          <marquee direction="right" loop>
            <ul className='mb-0 d-flex align-items-center'>
              <li>
                <img src={`${finalURL}/Assets/Images/discount.svg`} alt='Discount' />
                <span className='offer'>First order Discount: Flat 2%</span>
              </li>
              <li className='ps-3 pe-3 text-white'>|</li>
              <li>
                <img src={`${finalURL}/Assets/Images/discount.svg`} alt='Discount' />
                <span className='offer'>Deal of the day coupon: Flat 50</span>
              </li>
            </ul>
          </marquee>
        </div>
      </div>
      <header className='header'>
        <div className='container-fluid'>
          <div className="navbar navbar-expand-lg justify-content-between pt-3 pb-3 flex-wrap ">
            <Area
              id="header"
              noOuter
              coreComponents={[
                {
                  component: { default: Area },
                  props: {
                    id: 'icon-wrapper',
                    className: 'd-flex align-items-center auth-icon'
                  },
                  sortOrder: 20
                }
              ]}
            />
          </div>
        </div>
      </header>
      <main className="content">
        <Area id="content" className="" noOuter />
      </main>
      <div className="footer">
        <Area id="footer" noOuter coreComponents={[]} />
      </div>
    </>
  );
}

export const layout = {
  areaId: 'body',
  sortOrder: 1
};
