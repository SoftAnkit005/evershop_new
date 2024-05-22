import PropTypes from 'prop-types';
import React from 'react';
import { Field } from '@components/common/form/Field';
import { Form } from '@components/common/form/Form';
import './../../../../Styles/Styles.scss';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import Area from '@components/common/Area';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

export default function LoginForm({
  action,
  homeUrl,
  registerUrl,
  forgotPasswordUrl
}) {
  const [error, setError] = React.useState(null);

  return (
    <>
      <section className='login-section'>
        <div className='container'>
          <div className='row align-items-center'>
            <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
              <div className='login-wrapper'>
                <div className='w-100'>
                  <div className='text-center'>
                    <h4 className="font-30 text-white">{_('Login')}</h4>
                    <p className='font-16 text-white'>welcome to Dr.BWC</p>
                    {error && <div className="text-critical mb-1">{error}</div>}
                    <Form
                      id="loginForm"
                      action={action}
                      isJSON
                      method="POST"
                      onSuccess={(response) => {
                        if (!response.error) {
                          window.location.href = homeUrl;
                        } else {
                          setError(response.error.message);
                        }
                      }}
                      btnText={_('SIGN IN')}
                    >
                      <Area
                        id="loginFormInner"
                        coreComponents={[
                          {
                            component: { default: Field },
                            props: {
                              name: 'email',
                              type: 'text',
                              placeholder: _('Email'),
                              validationRules: ['notEmpty', 'email']
                            },
                            sortOrder: 10
                          },
                          {
                            component: { default: Field },
                            props: {
                              name: 'password',
                              type: 'password',
                              placeholder: _('Password'),
                              validationRules: ['notEmpty']
                            },
                            sortOrder: 20
                          }
                        ]}
                      />
                    </Form>
                    <div className='forgot-password mt-4'>
                      <div>
                        <input className="styled-checkbox" id="styled-checkbox-1" type="checkbox" value="value1" />
                        <label htmlFor="styled-checkbox-1" className='font-16 text-white'>Checkbox</label>
                      </div>
                      <a href={forgotPasswordUrl} className='font-16 text-white text-decoration-none pb-0'>Lost your password ?</a>
                    </div>
                    <p className='text-center font-16 text-white fw-lighter mt-4'>don't have an  account? <a href={registerUrl} className='ms-1 text-white text-decoration-none fw-bold' >register</a></p>
                  </div>
                </div>
              </div>
            </div>
            <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
              <div className='register-info'>
                <h4 className="font-30 text-white mb-4">Register</h4>
                <p className='font-16 text-white mb-4'>Registering for this site allows you to access your order status and history. Just fill in the fields below, and we'll get a new account set up for you in no time. We will only ask you for information necessary to make the purchase process faster and easier.</p>
                <a className="btn-white w-50 text-center d-block ms-auto me-auto" href={registerUrl}>Create an account</a>
              </div>
            </div>
          </div>
        </div>
      </section>

    </>
  );
}

LoginForm.propTypes = {
  action: PropTypes.string.isRequired,
  homeUrl: PropTypes.string.isRequired,
  registerUrl: PropTypes.string.isRequired,
  forgotPasswordUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    homeUrl: url(routeId: "homepage")
    action: url(routeId: "customerLoginJson")
    registerUrl: url(routeId: "register")
    forgotPasswordUrl: url(routeId: "resetPasswordPage")
  }
`;
