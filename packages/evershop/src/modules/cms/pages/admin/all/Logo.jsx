import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import './Logo.scss';
import "../../../../Styles/admin.scss"

export default function Logo({ dashboardUrl }) {

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
      <a href={dashboardUrl} className="flex items-end">
        <img
          width={120}
          height={120}
          alt="DR.Bwc"
          src={`${finalURL}/Assets/Images/header_logo.svg`}
        />
      </a>
    </div>
  );
}

Logo.propTypes = {
  dashboardUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'header',
  sortOrder: 10
};

export const query = `
  query Query {
    dashboardUrl: url(routeId:"dashboard")
  }
`;
