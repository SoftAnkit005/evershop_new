import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import Area from '@components/common/Area';
import Button from '@components/common/form/Button';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import "../../../../Styles/Styles.scss";
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

function Name() {

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
    <>
      <section className='error-page text-center mt-5 mb-5'>
          <img src={`${finalURL}/Assets/Images/error.svg`} alt='Error Page' className='w-25'/>
      </section>
      <h1 className="page-name text-center mt-5">
        {_('404 Page Not Found')}
      </h1>
    </>
  );
}

function Content({ continueShoppingUrl }) {
  return (
    <div className="page-content">
      <div className="text-center">
        {_('The page you requested does not exist.')}
      </div>
      <div className="mt-2 text-center mb-5 mt-5">
        <Button
          title={_('Continue shopping')}
          url={continueShoppingUrl}
          outline
        />
      </div>
    </div>
  );
}

Content.propTypes = {
  continueShoppingUrl: PropTypes.string.isRequired
};

export default function NotFound({ continueShoppingUrl }) {
  return (
    <div className="page-width mt-25">
      <div className="pt-15">
        <Area
          id="notfound-page"
          coreComponents={[
            {
              component: { default: Name },
              props: {},
              sortOrder: 10,
              id: 'notfound-page-title'
            },
            {
              component: { default: Content },
              props: { continueShoppingUrl },
              sortOrder: 20,
              id: 'notfound-page-content'
            }
          ]}
        />
      </div>
    </div>
  );
}

NotFound.propTypes = {
  continueShoppingUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 10
};

export const query = `
  query Query {
    continueShoppingUrl: url(routeId: "homepage")
  }
`;
