import PropTypes from 'prop-types';
import React from 'react';
import { FaUser } from "react-icons/fa";

export default function UserIcon({ customer, accountUrl, loginUrl }) {
  return (
    <div className="self-center">
      <a className='' href={customer ? accountUrl : loginUrl} aria-label={customer ? "Go to account" : "Log in"}>
        <FaUser className='text-theme-brown fs-1' />
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
  sortOrder: 30
};

export const query = `
  query Query {
    customer: currentCustomer {
      uuid
      fullName
      email
    }
    accountUrl: url(routeId: "account")
    loginUrl: url(routeId: "login")
  }
`;
