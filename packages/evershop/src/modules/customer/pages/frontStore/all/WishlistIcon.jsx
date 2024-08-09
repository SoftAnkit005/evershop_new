import PropTypes from 'prop-types';
import React from 'react';
import { FaUser } from "react-icons/fa";
import { FaHeart } from 'react-icons/fa6';

export default function UserIcon({ customer, accountUrl, loginUrl }) {
  return (
    <div className="self-center">
      <a className='' href={customer ? '/wishlist' : loginUrl} aria-label={customer ? "wishlist" : "Log in"}>
        <FaHeart className='text-theme-brown fs-1' />
      </a>
    </div>
  );
}

UserIcon.propTypes = {
  accountUrl: PropTypes.string,
  customer: PropTypes.shape({
    email: PropTypes.string.isRequired,
    fullName: PropTypes.string.isRequired,
    uuid: PropTypes.string.isRequired
  }),
  loginUrl: PropTypes.string.isRequired
};

UserIcon.defaultProps = {
  accountUrl: null,
  customer: null
};

export const layout = {
  areaId: 'icon-wrapper',
  sortOrder: 10
};

export const query = `
  query Query {
    customer: currentCustomer {
      uuid
      fullName
      email
    }
    loginUrl: url(routeId: "login")
  }
`;
