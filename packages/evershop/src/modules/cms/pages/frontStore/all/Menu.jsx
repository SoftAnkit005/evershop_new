import PropTypes from 'prop-types';
import React from 'react';
import './Menu.scss';

export default function Menu({ menu: { items } }) {
  // const currentPath = window.location.pathname;
  // const currentPath = window.location.href;

  return (
    <div className='header-menu'>
      <ul className="list-unstyled d-flex mb-0">
        {items.map((item, index) => (
          <li className="nav-item p-0 m-0" key={index}>
            {/* <a className={`header-link ${currentPath === item.url ? 'active' : ''}`} href={item.url}>
              {item.name}
            </a> */}
             <a className={`header-link`} href={item.url}>
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
  areaId: 'header',
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
