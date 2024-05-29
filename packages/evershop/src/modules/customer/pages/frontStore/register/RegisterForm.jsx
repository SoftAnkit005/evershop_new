import PropTypes from 'prop-types';
import React from 'react';
import { Field } from '@components/common/form/Field';
import { Form } from '@components/common/form/Form';
import './RegisterForm.scss';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import Area from '@components/common/Area';
import "../../../../Styles/Styles.scss";
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

export default function RegisterForm({ action, homeUrl, loginApi, loginUrl }) {
  const [error, setError] = React.useState(null);
  const [email, setEmail] = React.useState(null);
  const [password, setPassword] = React.useState(null);

  return (

    <section className='login-section'>
      <div className='container'>
        <div className='row align-items-center'>
          <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
            <div className='login-wrapper'>
              <div className='w-100'>
                <div className='text-center'>
                  <h4 className="font-30 text-white">{_('Create A New Account')}</h4>
                  <p className='font-16 text-white'>welcome to Dr.BWC</p>
                  {error && <div className="text-critical mb-1">{error}</div>}
                  <Form
                    id="registerForm"
                    action={action}
                    isJSON
                    method="POST"
                    onSuccess={async (response) => {
                      if (!response.error) {
                        // Log the customer in
                        const loginResponse = await fetch(loginApi, {
                          method: 'POST',
                          headers: {
                            'Content-Type': 'application/json'
                          },
                          body: JSON.stringify({
                            email,
                            password
                          })
                        });

                        const loginResponseJson = await loginResponse.json();
                        if (loginResponseJson.error) {
                          setError(loginResponseJson.error.message);
                        } else {
                          window.location.href = homeUrl;
                        }
                      } else {
                        setError(response.error.message);
                      }
                    }}
                    btnText={_('SIGN UP')}
                  >
                    <Area
                      id="customerRegisterForm"
                      coreComponents={[
                        {
                          component: {
                            default: (
                              <Field
                                name="full_name"
                                type="text"
                                placeholder={_('Full Name')}
                                validationRules={['notEmpty']}
                              />
                            )
                          },
                          sortOrder: 10
                        },
                        {
                          component: {
                            default: (
                              <Field
                                name="email"
                                type="text"
                                placeholder={_('Email')}
                                validationRules={['notEmpty', 'email']}
                                onChange={(e) => {
                                  setEmail(e.target.value);
                                }}
                              />
                            )
                          },
                          sortOrder: 20
                        },
                        {
                          component: {
                            default: (
                              <Field
                                name="password"
                                type="password"
                                placeholder={_('Password')}
                                validationRules={['notEmpty']}
                                onChange={(e) => {
                                  setPassword(e.target.value);
                                }}
                              />
                            )
                          },
                          sortOrder: 30
                        }
                      ]}
                    />
                  </Form>
                  <div className="text-center mt-1">
                    <span className='text-center font-16 text-white fw-lighter mt-4'>
                      {_('Already have an account?')}
                      <b>
                        <a className="text-decoration-none text-white fw-bold " href={loginUrl}>
                          {' '}
                          {_('Login')}{' '}
                        </a>
                      </b>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
            <div className='register-info'>
              <h4 className="font-30 text-white mb-4">Login</h4>
              <p className='font-16 text-white mb-4'>Registering for this site allows you to access your order status and history. Just fill in the fields below, and we wll get a new account set up for you in no time. We will only ask you for information necessary to make the purchase process faster and easier.</p>
              <div className='d-block'>
                <a className='btn-white w-50 text-center d-block ms-auto me-auto' href={loginUrl}>Login</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

RegisterForm.propTypes = {
  action: PropTypes.string.isRequired,
  homeUrl: PropTypes.string.isRequired,
  loginApi: PropTypes.string.isRequired,
  loginUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    homeUrl: url(routeId: "homepage")
    action: url(routeId: "createCustomer")
    loginApi: url(routeId: "customerLoginJson")
    loginUrl: url(routeId: "login")
  }
`;
