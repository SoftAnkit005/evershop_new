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
      <div className="reset-password-form flex justify-center items-center">
        <div className="reset-password-form-inner">
          <p className="text-center text-success">
            {_(
              'We have sent you an email with a link to reset your password. Please check your inbox.'
            )}
          </p>
        </div>
      </div>
    </div>
  );
}

function ResetForm({ action, onSuccess, registerUrl }) {
  const [error, setError] = React.useState(null);
  const [loading, setLoading] = React.useState(false);

  return (


    <section className='login-section'>
      <div className='container'>
        <div className='row align-items-center'>
          <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
            <div className='login-wrapper'>
              <div className='w-100'>
                <div className='text-center'>
                  <h4 className="font-30 text-white">{_('Enter your email address')}</h4>
                  <p className='font-16 text-white'>welcome to Dr.BWC</p>
                  {error && <div className="text-critical mb-1">{error}</div>}
                  <Form
                    id="resetPasswordForm"
                    action={action}
                    isJSON
                    method="POST"
                    onStart={() => {
                      setLoading(true);
                    }}
                    onSuccess={(response) => {
                      if (!response.error) {
                        onSuccess();
                      } else {
                        setError(response.error.message);
                      }
                    }}
                    onComplete={() => {
                      setLoading(false);
                    }}
                    submitBtn={false}
                  >
                    <Field
                      name="email"
                      type="text"
                      placeholder={_('Email')}
                      validationRules={['notEmpty', 'email']}
                    />
                    <Button
                      title={_('RESET PASSWORD')}
                      type="submit"
                      onAction={() => {
                        document
                          .getElementById('resetPasswordForm')
                          .dispatchEvent(
                            new Event('submit', { cancelable: true, bubbles: true })
                          );
                      }}
                      isLoading={loading}
                    />
                  </Form>
                </div>
              </div>
            </div>
          </div>
          <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
            <div className='register-info'>
              <h4 className="font-30 text-white mb-4">Reset Password</h4>
              <p className='font-16 text-white mb-4'>Registering for this site allows you to access your order status and history. Just fill in the fields below, and we wll get a new account set up for you in no time. We will only ask you for information necessary to make the purchase process faster and easier.</p>
              <a className='btn-white w-50 text-center d-block ms-auto me-auto' href={registerUrl}>
                {_('Create an account')}
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

ResetForm.propTypes = {
  action: PropTypes.string.isRequired,
  onSuccess: PropTypes.func.isRequired,
  registerUrl: PropTypes.string.isRequired
};

export default function ResetPasswordForm({ action, registerUrl }) {
  const [success, setSuccess] = React.useState(null);

  return success ? (
    <Success />
  ) : (
    <ResetForm
      action={action}
      registerUrl={registerUrl}
      onSuccess={() => {
        setSuccess(true);
      }}
    />
  );
}

ResetPasswordForm.propTypes = {
  action: PropTypes.string.isRequired,
  registerUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    action: url(routeId: "resetPassword"),
    registerUrl: url(routeId: "register")
  }
`;
