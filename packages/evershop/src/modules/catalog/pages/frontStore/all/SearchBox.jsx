import PropTypes from 'prop-types';
import React, { useEffect, useRef, useState } from 'react';
import { Input } from '@components/common/form/fields/Input';
import XIcon from '@heroicons/react/solid/esm/XIcon';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import './SearchBox.scss';
import { useDebounce } from 'use-debounce';
import axios from 'axios';

export default function SearchBox({ searchPageUrl }) {
  const InputRef = useRef();
  // Get the key from the URL
  const [keyword, setKeyword] = useState(null);
  const [showing, setShowing] = useState(false);

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

  // const [value] = useDebounce(keyword, 1500);
  // const [searchList, setsearchList] = useState([]);
  // const isInitialRender = useRef(true);

  // useEffect(() => {
  //   if (isInitialRender.current || keyword === "") {
  //     // Skip the effect on the initial render
  //     isInitialRender.current = false;
  //   } else {
  //     const searchProduct = async () => {
  //       try {
  //         const options = {
  //           headers: {"content-type": "application/json"}
  //         }
  //         const body = {
  //           keyword: keyword,
  //         };
  //         const response = await axios.post(`${finalURL}/api/getsearchdata`, body ,options);
  //         setsearchList(response.data);
  //         console.log(response.data);
  //       } catch (error) {
  //         console.error('Error fetching data:', error);
  //       }
  //     }
  //     searchProduct();
  //   }
  // }, [value])

  return (
    <div className="search-box">
      <a href="#" className="search-icon" onClick={(e) => { e.preventDefault(); setShowing(!showing); InputRef.current.focus(); }} aria-label="Toggle search" >
        <svg xmlns="http://www.w3.org/2000/svg" style={{ width: '2.2rem', height: '2.2rem' }} fill="none" viewBox="0 0 24 24" stroke="#CDA646" > <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /> </svg>
      </a>
      {showing && (
        <div className="search-input-container">
          <div className="search-input">
            <a href="#" className="close-icon" style={{width:'22px'}} onClick={(e) => { e.preventDefault(); setsearchList([]); setKeyword(""); InputRef.current.value = "" }} aria-label="Close" > <XIcon className='fs-2 text-white' /> </a>
            <Input placeholder={_('Search')} ref={InputRef} value={keyword} onChange={(e) => { setKeyword(e.target.value); }} />
          </div>
          <div className='search-list'>
            {/* <ul className='bg-dark list-unstyled'>
              {searchList?.map((item) => 
                <li>
                  <a className='btn btn-dark border-bottom w-100 text-start p-3 text-decoration-none' href={`${finalURL}/${(item.parent_category_url_key !== null)?item.parent_category_url_key+'/':''}${item.category_url_key}/${item.product_url_key}`}>
                    <p className='ellipsis-1'>{item.product_name}</p>
                    <p className='mb-0 mt-1'>{item.category_name}</p>
                  </a>
                </li>
              )}
            </ul> */}
          </div>
        </div>
      )}
    </div>
  );
}

SearchBox.propTypes = {
  searchPageUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'icon-wrapper',
  sortOrder: 5
};

export const query = `
  query Query {
    searchPageUrl: url(routeId: "catalogSearch")
  }
`;