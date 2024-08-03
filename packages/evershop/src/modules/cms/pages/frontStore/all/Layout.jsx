import React, { useEffect, useRef, useState } from 'react';
import Area from '@components/common/Area';
import LoadingBar from '@components/common/LoadingBar';
import { Input } from '@components/common/form/fields/Input';
import XIcon from '@heroicons/react/solid/esm/XIcon';


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


export default function Layout({ allProducts =[] }) {
  const InputRef = useRef();
  const [finalURL, setFinalURL] = useState('');
  const placeholderTexts = ["Welcome to Dr.Bwc", "Eco Friendly Products"];
  const typeablePlaceholder = useTypeablePlaceholder(placeholderTexts);
  const [keyword, setKeyword] = useState(null);
  const [listDisplay, setlistDisplay] = useState('d-none')
  const [filteredData, setFilteredData] = useState(allProducts);

  useEffect(() => {
    console.log(allProducts);
    const currentURL = window.location.href; 
    const newURL = currentURL.replace(currentURL, '');
    const pathStartIndex = newURL.indexOf('/', 8);
    const newPath = newURL.substring(pathStartIndex);
    const finalURL = window.location.origin + newPath;
    setFinalURL(finalURL);
  }, []);

  
  const handleSearch = (event) => {
    if(event.target.value === ""){
        setlistDisplay('d-none')
    } else
        setlistDisplay('d-block')
    const value = event.target.value.toLowerCase();
    setKeyword(value);
    const filtered = allProducts.filter(item =>
      item.productName.toLowerCase().includes(value)
    );
    setFilteredData(filtered);
  };

  

  return (
    <>
      <LoadingBar />

      <div className='text-center offer-top discount-coupon'>
        <div className='w-100 discount-coupon-content'>
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
          <div className="navbar navbar-expand-lg pb-3 position-relative">
            <div className="search-input-container search-container-lg-view">
              <div className="search-input">
                <Input
                  prefix={
                    <a href="#" className={`close-icon ${(keyword !== null && keyword !== "")?"d-block":"d-none"}`} style={{width:'22px'}} onClick={(e) => { e.preventDefault(); setFilteredData([]); setKeyword(""); InputRef.current.value = "" }} aria-label="Close" > <XIcon className='fs-6 text-white' /> </a>
                  }
                  placeholder={typeablePlaceholder}
                  ref={InputRef}
                  value={keyword || ''}
                  onChange={(e) => handleSearch(e)}
                />
                <div className={`search-list ${listDisplay}`}>
                  <ul className='bg-dark list-unstyled'>
                    {filteredData?.map((item) => 
                      <li>
                        <a className='btn btn-dark border-bottom w-100 text-start p-3 text-decoration-none' href={`${finalURL}/${(item.parentCategoryUrlKey !== null)?item.parentCategoryUrlKey+'/':''}${item.categoryUrlKey}/${item.productUrlKey}`}>
                          <p className='ellipsis-1'>{item.productName}</p>
                          <p className='mb-0 mt-1'>{item.categoryName}</p>
                        </a>
                      </li>
                    )}
                  </ul>
                </div>
              </div>
            </div>
            <Area
              id="header"
              noOuter
              coreComponents={[
                {
                  component: { default: Area },
                  props: {
                    id: 'icon-wrapper',
                    className: 'd-flex align-items-center position-absolute end-0 auth-icon gap-sm-4 gap-lg-5'
                  },
                  sortOrder: 20
                }
              ]}
            />
          </div>
          <div className='col-xxl-10 m-auto'>
            <Area id="header-menu" noOuter coreComponents={[]} />
          </div>
        </div>
      </header>
      { /* <div className='mobile-menu'>
        <Area id="header-menu" noOuter coreComponents={[]} />
      </div> */ }
      <main className="content position-relative z-0">
        <Area id="content" className="" noOuter />
      </main>
      <div className="footer">
        <Area id="footer" noOuter coreComponents={[]} />
      </div>
    </>
  );
}


// Layout.propTypes = {
//   searchPageUrl: PropTypes.string.isRequired
// };

export const layout = {
  areaId: 'body',
  sortOrder: 1
};


export const query = `
  query {
    allProducts {
      productName
      categoryName
      parentCategoryName
      productUrlKey
      categoryUrlKey
      parentCategoryUrlKey
    }
  }`;
