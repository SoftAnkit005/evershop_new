import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import { Field } from '@components/common/form/Field';
import { Form } from '@components/common/form/Form';
import './LoginForm.scss';

export default function LoginForm({ authUrl, dashboardUrl }) {
  const [error, setError] = React.useState(null);

  const onSuccess = (response) => {
    if (!response.error) {
      window.location.href = dashboardUrl;
    } else {
      setError(response.error.message);
    }
  };

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
    <div className="admin-login-form">
      <div className="flex items-center justify-center mb-3">
        <img
         
          alt="EverShop Admin Panel"
          src={`${finalURL}/Assets/Images/footer_logo.svg`}
        />
      </div>
      {error && <div className="text-critical py-1">{error}</div>}
      <Form
        action={authUrl}
        method="POST"
        id="adminLoginForm"
        isJSON
        onSuccess={onSuccess}
        btnText="SIGN IN"
      >
        <Field
          name="email"
          type="email"
          label="Email"
          placeholder="Email"
          validationRules={['notEmpty', 'email']}
        />
        <Field
          name="password"
          type="password"
          label="Password"
          placeholder="Password"
          validationRules={['notEmpty']}
        />
      </Form>
    </div>
  );
}

LoginForm.propTypes = {
  authUrl: PropTypes.string.isRequired,
  dashboardUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    authUrl: url(routeId: "adminLoginJson")
    dashboardUrl: url(routeId: "dashboard")
  }
`;
