import PropTypes from 'prop-types';
import React from 'react';
import Chervon from '@heroicons/react/outline/ChevronRightIcon';
import Area from '@components/common/Area';
import {
  CheckoutSteps,
  useCheckoutSteps,
  useCheckoutStepsDispatch
} from '@components/common/context/checkoutSteps';
import { CheckoutProvider } from '@components/common/context/checkout';
import './Checkout.scss';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import './../../../../Styles/Styles.scss';
import './../../../../catalog/pages/frontStore/categoryView/Index.scss';

function Steps() {
  return (
    <Area id="checkoutSteps" className="checkout-steps" coreComponents={[]} />
  );
}

function Breadcrumb() {
  const steps = useCheckoutSteps();
  return (
    <div className="mb-2 mt-1 flex checkout-breadcrumb font-16">
      {steps.map((step, index) => {
        const separator =
          index < steps.length - 1 ? (
            <span className="separator">
              <Chervon width={10} height={10} />
            </span>
          ) : null;
        if (step.isCompleted === true) {
          return (
            <span key={step.id} className="text-muted flex items-center">
              <span>{step.title}</span> {separator}
            </span>
          );
        } else {
          return (
            <span key={step.id} className="flex items-center">
              <span>{step.title}</span> {separator}
            </span>
          );
        }
      })}
    </div>
  );
}

function CompletedSteps() {
  const steps = useCheckoutSteps();
  const { editStep } = useCheckoutStepsDispatch();
  const completedSteps = steps.filter(
    (step, index) => step.isCompleted === true && index < steps.length - 1
  );
  if (completedSteps.length === 0) {
    return null;
  }

  return (
    <div className="mt-1 mb-5">
      <div className="checkout-completed-steps border rounded px-2 border-divider divide-y">
        {completedSteps.map((step) => (
          <div
            key={step.id}
            className="p-4"
          >
            <p className='font-16 pb-0 text-black'>{step.previewTitle}</p>
            <div className="d-flex align-items-center justify-content-between">
                <p className='font-16 pb-0'>{step.preview}</p>
                {step.editable && (
                  <a
                    href="#"
                    className="text-interactive hover:underline"
                    onClick={(e) => {
                      e.preventDefault();
                      editStep(step.id);
                    }}
                  >
                    {_('Change')}
                  </a>
                )}
              
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default function CheckoutPage({
  checkout: { cartId },
  placeOrderAPI,
  getPaymentMethodAPI,
  checkoutSuccessUrl
}) {
  return (
    <CheckoutSteps value={[]}>
      <CheckoutProvider
        cartId={cartId}
        placeOrderAPI={placeOrderAPI}
        getPaymentMethodAPI={getPaymentMethodAPI}
        checkoutSuccessUrl={checkoutSuccessUrl}
      >
        <div className="page-width grid grid-cols-1 md:grid-cols-2 gap-3 mt-5 mb-5">
          <Area
            id="checkoutPageLeft"
            coreComponents={[
              {
                component: { default: Breadcrumb },
                sortOrder: 10
              },
              {
                component: { default: CompletedSteps },
                sortOrder: 15
              },
              {
                component: { default: Steps },
                sortOrder: 20
              }
            ]}
          />
          <Area id="checkoutPageRight" />
        </div>
      </CheckoutProvider>
    </CheckoutSteps>
  );
}

CheckoutPage.propTypes = {
  checkoutSuccessUrl: PropTypes.string.isRequired,
  getPaymentMethodAPI: PropTypes.string.isRequired,
  placeOrderAPI: PropTypes.string.isRequired,
  checkout: PropTypes.shape({
    cartId: PropTypes.string.isRequired
  }).isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    checkout {
      cartId
    }
    placeOrderAPI: url(routeId: "createOrder")
    getPaymentMethodAPI: url(routeId: "getPaymentMethods")
    checkoutSuccessUrl: url(routeId: "checkoutSuccess")
  }
`;
