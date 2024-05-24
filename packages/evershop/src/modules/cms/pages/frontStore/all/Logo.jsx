import PropTypes from 'prop-types';
import React, { useEffect, useRef, useState } from 'react';
import { Input } from '@components/common/form/fields/Input';
import XIcon from '@heroicons/react/solid/esm/XIcon';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

export default function Logo({
  themeConfig: {
    logo: { src, alt = 'Dr.Bwc', width = '128px', height = '128px' }
  }
})

{

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


  return (
    <div className="logo">
      {src && (
        <a href="/" className="logo-icon">
          <img src={src} alt={alt} width={width} height={height} />
        </a>
      )}
      {!src && (
        <a href="/" className="logo-icon">
          <img src={`${finalURL}/Assets/Images/header_logo.svg`} alt='Header Logo'/>
        </a>
      )}
      <div className="search-input">
            <a
              href="#"
              className="close-icon"
              onClick={(e) => {
                e.preventDefault();
                setShowing(false);
              }}
             />
            <Input
              prefix={
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  style={{ width: '1.8rem', height: '1.8rem' }}
                  fill="none"
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
              placeholder={_('Search')}
              ref={InputRef}
              value={keyword}
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
  );
}

Logo.propTypes = {
  themeConfig: PropTypes.shape({
    logo: PropTypes.shape({
      src: PropTypes.string,
      alt: PropTypes.string,
      width: PropTypes.string,
      height: PropTypes.string
    })
  })
};

Logo.defaultProps = {
  themeConfig: {
    logo: {
      src: '',
      alt: 'Dr.Bwc',
      width: '128',
      height: '146'
    }
  }
};

export const layout = {
  areaId: 'header',
  sortOrder: 1
};

export const query = `
  query query {
    themeConfig {
      logo {
        src
        alt
        width
        height
      }
    }
  }
`;
