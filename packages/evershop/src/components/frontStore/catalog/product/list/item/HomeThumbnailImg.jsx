import PropTypes from 'prop-types';
import React from 'react';
import '@components/frontStore/catalog/product/list/item/Thumbnail.scss';
import ProductNoThumbnail from '@components/common/ProductNoThumbnail';

function HomeThumbnailImg({ url, imageUrl, alt }) {
  return (
    <div className='col-12 col-sm-12 col-md-6 col-lg-6'>
      <div className="products-img">
        {imageUrl && (
          <a href={url} className='m-auto'>
            <img src={imageUrl} alt={alt} />
          </a>
        )}
        {!imageUrl && (
          <a href={url} aria-label="View Product Details">
            <ProductNoThumbnail width={100} height={100} />
          </a>
        )}
      </div>
    </div>
  );
}

HomeThumbnailImg.propTypes = {
  alt: PropTypes.string,
  imageUrl: PropTypes.string,
  url: PropTypes.string
};

HomeThumbnailImg.defaultProps = {
  alt: '',
  imageUrl: '',
  url: ''
};

export { HomeThumbnailImg };
