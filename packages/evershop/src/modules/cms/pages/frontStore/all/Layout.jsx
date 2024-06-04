import React, { useEffect, useRef, useState } from 'react';
import Area from '@components/common/Area';
import LoadingBar from '@components/common/LoadingBar';
import { Input } from '@components/common/form/fields/Input';
import PropTypes from 'prop-types';


const useTypeablePlaceholder = (texts) => {
  const [displayText, setDisplayText] = useState('');
  const [placeholderIndex, setPlaceholderIndex] = useState(0);
  const [charIndex, setCharIndex] = useState(0);

  useEffect(() => {
    const timeout = setTimeout(() => {
      if (charIndex < texts[placeholderIndex].length) {
        setDisplayText((prev) => prev + texts[placeholderIndex][charIndex]);
        setCharIndex(charIndex + 1);
      } else {
        setTimeout(() => {
          setDisplayText('');
          setCharIndex(0);
          setPlaceholderIndex((placeholderIndex + 1) % texts.length);
        }, 2000);
      }
    }, 100);

    return () => clearTimeout(timeout);
  }, [charIndex, placeholderIndex, texts]);

  return displayText;
};


export default function Layout({ searchPageUrl }) {
  const InputRef = useRef();
  const [finalURL, setFinalURL] = useState('');
  const [keyword, setKeyword] = useState(null);
  const placeholderTexts = ["Welcome to Dr.Bwc", "Eco Friendly Products"];
  const typeablePlaceholder = useTypeablePlaceholder(placeholderTexts);

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
          <div className="navbar navbar-expand-lg pt-3 pb-3">
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
      <div className='mobile-menu'>
        <div className="search-input-container">
          <div className="search-input">

            <Input
              prefix={
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  style={{ width: '1.8rem', height: '1.8rem' }}
                  fill="#FFF"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                  />
                </svg>
              }
              placeholder={typeablePlaceholder}
              ref={InputRef}
              value={keyword || ''}
              onChange={(e) => {
                setKeyword(e.target.value);
              }}
              onKeyPress={(event) => {
                if (event.key === 'Enter') {
                  // Redirect to search page with search query as the keyword in the url
                  const url = new URL(searchPageUrl, window.location.origin);
                  url.searchParams.set('keyword', InputRef.current.value);

                  window.location.href = url;
                }
              }}
            />
          </div>
        </div>
        <Area id="header" noOuter coreComponents={[]} />
      </div>
      <main className="content">
        <Area id="content" className="" noOuter />
      </main>
      <div className="footer">
        <Area id="footer" noOuter coreComponents={[]} />
      </div>
    </>
  );
}


Layout.propTypes = {
  searchPageUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'body',
  sortOrder: 1
};
