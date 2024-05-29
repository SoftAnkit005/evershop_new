import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';

export default function Logo({
  themeConfig: {
    logo: { src, alt = 'Dr.Bwc', width = '128px', height = '128px' }
  }
}) {

  React.useEffect(() => {
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
          <img src={`${finalURL}/Assets/Images/header_logo.svg`} alt='Header Logo' />
        </a>
      )}

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
