import PropTypes from 'prop-types';
import './Menu.scss';
import React, { useState, useEffect } from 'react';

export default function Menu({ menu: { items } }) {

  const [currentPath, setCurrentPath] = useState('');
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const path = window.location.href;
      const currentPath = path.replace(window.location.origin, '');
      setCurrentPath(currentPath);
    }
  }, []);
  const renderSubMenu = (children) => (
    <ul className="dropdown-menu" aria-labelledby="navbarDropdown">
      {children.map((child, childIndex) => (
        <li key={childIndex}>
          <a className={`dropdown-item ${currentPath === child.url ? 'active' : ''}`} href={child.url}>
            {child.name}
          </a>
        </li>
      ))}
    </ul>
  );

  return (
    <div className='header-menu py-3'>
      <ul className="list-unstyled d-flex mb-0">
        {items.map((item, index) => (
          <li className={`nav-item p-0 m-0 ${item.children.length > 0 ? 'dropdown' : ''}`} key={index}>
            <a className={`nav-link menulist ${item.children.length > 0 ? 'dropdown-toggle' : ''} ${currentPath === item.url ? 'active' : ''}`} href={item.url} id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              {item.name}
            </a>
            {item.children.length > 0 && renderSubMenu(item.children)}
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
        parent_id
        children {
          name
          url
          parent_id        
        }
      }
    }
}`;


