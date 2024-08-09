import PropTypes from 'prop-types';
import React, { useEffect, useRef, useState } from 'react';
import { Input } from '@components/common/form/fields/Input';
import XIcon from '@heroicons/react/solid/esm/XIcon';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import './SearchBox.scss';

export default function SearchBox({ allProducts =[] }) {
  const InputRef = useRef();
  const [showing, setShowing] = useState(false);
  const [keyword, setKeyword] = useState(null);
  const [listDisplay, setlistDisplay] = useState('d-none')
  const [filteredData, setFilteredData] = useState(allProducts);

  React.useEffect(() => {
    const url = new URL(window.location.href);
    const key = url.searchParams.get('keyword');
    setKeyword(key);
  }, []);

  const [finalURL, setFinalURL] = useState('');
  useEffect(() => {
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
    <div className="search-box">
      <a href="#" className="search-icon" onClick={(e) => { e.preventDefault(); setShowing(!showing); InputRef.current.focus(); }} aria-label="Toggle search" >
        <svg xmlns="http://www.w3.org/2000/svg" style={{ width: '2.2rem', height: '2.2rem' }} fill="none" viewBox="0 0 24 24" stroke="#CDA646" > <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /> </svg>
      </a>
      {showing && (
        <div className="search-input-container">
          <div className="search-input">
            <a href="#" className="close-icon" style={{width:'22px'}} onClick={(e) => { e.preventDefault(); setFilteredData([]); setKeyword(""); InputRef.current.value = "" }} aria-label="Close" > <XIcon className='fs-2 text-white' /> </a>
            <Input placeholder={_('Search')} ref={InputRef} value={keyword} onChange={(e) => handleSearch(e)} />
          </div>
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
      )}
    </div>
  );
}

export const layout = {
  areaId: 'icon-wrapper',
  sortOrder: 5
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
