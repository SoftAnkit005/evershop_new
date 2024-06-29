import PropTypes from 'prop-types';
import './Menu.scss';
import React, { useState, useEffect } from 'react';

export default function Menu({ menu: { items } }) {
  // const currentPath = window.location.href;
  // const currentPath = window.location.origin;

  const [currentPath, setCurrentPath] = useState('');
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const path = window.location.href;
      const currentPath = path.replace(window.location.origin, '');
      setCurrentPath(currentPath);
    }
  }, []);

  // return (
  //   <div className='header-menu py-3'>
  //     <ul className="list-unstyled d-flex mb-0">
  //       {items.map((item, index) => (
  //         <li className="nav-item p-0 m-0" key={index}>

  //           <a className="header-link" href={item.url}>
  //             {item.name}
  //           </a>

  //           {/* <a className={`header-link ${currentPath === item.url ? 'active' : ''}`} href={item.url}>
  //             {item.name}
  //           </a> */}
  //         </li>
  //       ))}
  //     </ul>
  //   </div>
  // );
  return (
    <div className='header-menu py-3'>
      <ul className="list-unstyled d-flex mb-0">
        {items.map((item, index) => (
          <li className="nav-item p-0 m-0" key={index}>
            <a className={`header-link ${currentPath === item.url ? 'active' : ''}`} href={item.url}>
              {item.name}
            </a>
          </li>
        ))}
      </ul>
    </div>
  );
}

Menu.propTypes = {
  menu: PropTypes.shape({
    items: PropTypes.arrayOf(
      PropTypes.shape({
        name: PropTypes.string.isRequired,
        url: PropTypes.string.isRequired
      })
    ).isRequired
  }).isRequired
};

export const layout = {
  areaId: 'header-menu',
  sortOrder: 10
};

export const query = `
  query {
    menu {
      items {
        name
        url
      }
    }
}`;
