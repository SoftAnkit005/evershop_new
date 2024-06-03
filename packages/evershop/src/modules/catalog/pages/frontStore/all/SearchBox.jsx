import PropTypes from 'prop-types';
import React, { useEffect, useRef, useState } from 'react';
import { Input } from '@components/common/form/fields/Input';
import XIcon from '@heroicons/react/solid/esm/XIcon';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import './SearchBox.scss';

// Custom hook for typeable placeholder
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

export default function SearchBox({ searchPageUrl }) {
  const InputRef = useRef();
  const [keyword, setKeyword] = useState(null);
  const [showing, setShowing] = useState(false);

  // Placeholder texts for the typeable effect
  const placeholderTexts = ["Welcome to Dr.Bwc", "Eco Friendly Products"];
  const typeablePlaceholder = useTypeablePlaceholder(placeholderTexts);

  useEffect(() => {
    const url = new URL(window.location.href);
    const key = url.searchParams.get('keyword');
    setKeyword(key);
  }, []);

  return (
    <div className="search-box">
      <a
        href="#"
        className="search-icon"
        onClick={(e) => {
          e.preventDefault();
          setShowing(!showing);
          InputRef.current.focus();
        }}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          style={{ width: '2.2rem', height: '2.2rem' }}
          fill="none"
          viewBox="0 0 24 24"
          stroke="#CDA646"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth={2}
            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
          />
        </svg>
      </a>
      {showing && (
        <div className="search-input-container">
          <div className="search-input">
            <a
              href="#"
              className="close-icon"
              onClick={(e) => {
                e.preventDefault();
                setShowing(false);
              }}
            >
              <XIcon width="2rem" height="2rem" />
            </a>
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
