/* eslint-disable jsx-a11y/anchor-is-valid */
/* eslint-disable react/no-array-index-key */
import ProductNoThumbnail from '@components/common/ProductNoThumbnail';
import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import "../../../../Styles/Styles.scss"
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../categoryView/Index.scss"

function Current({ image }) {
  const [height, setHeight] = useState();

  

  useEffect(() => {
    setHeight(document.getElementById('product-current-image').offsetWidth);
  }, []);

  return (
    <div
      id="product-current-image"
      style={{ minHeight: height, background: '#f6f6f6' }}
      className="product-image product-single-page-image flex justify-center items-center"
    >
      {image && (
        <img src={image.single} alt={image.alt} className="self-center" />
      )}
      {!image && <ProductNoThumbnail width={250} height={250} />}
    </div>
  );
}

Current.propTypes = {
  image: PropTypes.shape({
    alt: PropTypes.string,
    single: PropTypes.string.isRequired
  }).isRequired
};

export default function Images({ product: { uuid, image, gallery = [] } }) {
  const [current, setCurrent] = React.useState(image);
  const [thumbs, setThumbs] = React.useState(gallery);



  const [finalURL, setFinalURL] = useState('');

  useEffect(() => {
      const currentURL = window.location.href;
      const newURL = currentURL.replace(currentURL, '');
      const pathStartIndex = newURL.indexOf('/', 8);
      const newPath = newURL.substring(pathStartIndex);
      const finalURL = window.location.origin + newPath;
      setFinalURL(finalURL);
  }, []);

 

  React.useEffect(() => {
    setCurrent(image);
    setThumbs(() => {
      const gls = [...gallery];
      if (image) {
        // Add image to beginning of gallery
        gls.unshift(image);
      }
      return gls;
    });
  }, [uuid]);

  
 

  return (
    <div className="product-single-media">
      <Current image={current} />
      <ul className="align-content-center flex gap-1 justify-content-between more-view-thumbnail mt-5 product-gallery">
        {thumbs.map((i, j) => (
          <li key={j} className="flex justify-center items-center">
            <a
              href="#"
              onClick={(e) => {
                e.preventDefault();
                setCurrent({ ...i });
              }}
              className=""
            >
              <img className="self-center" src={i.thumb} alt={i.alt} />
            </a>
          </li>
        ))}
      </ul> 
       
    </div>
  );
}

Images.propTypes = {
  product: PropTypes.shape({
    uuid: PropTypes.string.isRequired,
    image: PropTypes.shape({
      alt: PropTypes.string,
      single: PropTypes.string.isRequired
    }),
    gallery: PropTypes.arrayOf(
      PropTypes.shape({
        alt: PropTypes.string,
        single: PropTypes.string.isRequired
      })
    )
  }).isRequired
};

export const layout = {
  areaId: 'productPageMiddleLeft',
  sortOrder: 10
};

export const query = `
  query Query {
    product (id: getContextValue('productId')) {
      uuid
      image {
        alt
        thumb
        single
      }
      gallery {
        alt
        thumb
        single
      }
  }
}`;
