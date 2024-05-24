import PropTypes from 'prop-types';
import React from 'react';
import { Field } from '@components/common/form/Field';
import { Form } from '@components/common/form/Form';
import "../../../../Styles/Styles.scss";
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import Button from '@components/common/form/Button';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

function Success() {
  return (
    <div className="flex justify-center items-center">
      <div className="update-password-form flex justify-center items-center">
        <div className="update-password-form-inner">
          <p className="text-center text-success">
            {_(
              'Your password has been updated. You can now login with your new password.'
            )}
          </p>
        </div>
      </div>
    </div>
  );
}

function UpdateForm({ action, onSuccess, registerUrl }) {
  const [error, setError] = React.useState(null);
  const [token, setToken] = React.useState(null);
  const [loading, setLoading] = React.useState(false);

  React.useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);
    const tokenParam = urlParams.get('token');
    setToken(tokenParam);
  }, []);

  return (

    <section className='login-section'>
        <div className='container'>
          <div className='row align-items-center'>
            <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
              <div className='login-wrapper'>
                <div className='w-100'>
                  <div className='text-center'>
                    <h4 className="font-30 text-white">{_('Enter your new password')}</h4>
                    <p className='font-16 text-white'>welcome to Dr.BWC</p>
                    {error && <div className="text-critical mb-1">{error}</div>}
                    <Form
                      id="updatePasswordForm"
                      action={action}
                      isJSON
                      method="POST"
                      onStart={() => {
                        setLoading(true);
                      }}
                      onComplete={() => {
                        setLoading(false);
                      }}
                      onSuccess={(response) => {
                        if (!response.error) {
                          onSuccess();
                        } else {
                          setError(response.error.message);
                        }
                      }}
                      submitBtn={false}
                    >
                      <Field
                        name="password"
                        type="password"
                        placeholder={_('Password')}
                        validationRules={['notEmpty']}
                      />
                      <Field name="token" type="hidden" value={token} />
                      <div className="mt-1">
                        <Button
                          title={_('UPDATE PASSWORD')}
                          type="submit"
                          onAction={() => {
                            document
                              .getElementById('updatePasswordForm')
                              .dispatchEvent(
                                new Event('submit', { cancelable: true, bubbles: true })
                              );
                          }}
                          isLoading={loading}
                        />
                      </div>
                    </Form>
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
  );
}

UpdateForm.propTypes = {
  action: PropTypes.string.isRequired,
  onSuccess: PropTypes.func.isRequired,
  registerUrl: PropTypes.string.isRequired
};

export default function UpdatePasswordForm({ action, registerUrl }) {
  const [success, setSuccess] = React.useState(null);

  return success ? (
    <Success />
  ) : (
    <UpdateForm
      action={action}
      registerUrl={registerUrl} 
      onSuccess={() => {
        setSuccess(true);
      }}
    />
  );
}

UpdatePasswordForm.propTypes = {
  action: PropTypes.string.isRequired,
  registerUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    action: url(routeId: "updatePassword")
    registerUrl: url(routeId: "register")
  }
`;
