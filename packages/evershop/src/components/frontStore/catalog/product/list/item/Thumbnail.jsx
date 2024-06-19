import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import '@components/frontStore/catalog/product/list/item/Thumbnail.scss';
import ProductNoThumbnail from '@components/common/ProductNoThumbnail';
import axios from 'axios';


function Thumbnail({ url, imageUrl, alt, productId }) {
  const [tag, setTag] = useState('');

  useEffect(() => {
    async function getTag() {
      const tagData = await fetchTagData(productId);
      if (tagData && tagData.name) {
        setTag(tagData.name);
      } else {
        setTag('');
      }
    }
    getTag();
  }, [productId]);
  return (
    <div className='card-body'>
      
      {tag && <p className='static-note'>{tag}</p>}
      <div className="card-img">
        {imageUrl && (
          <a href={url}>
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



  
async function fetchTagData(productId) {
  try {
    const response = await axios.get(`/api/getproducttag/${productId}`);
    console.log(response)
    return response.data;
  } catch (error) {
    console.error('Error fetching tag data:', error);
    return null;
  }
}

Thumbnail.propTypes = {
  alt: PropTypes.string,
  imageUrl: PropTypes.string,
  productId: PropTypes.string,
  url: PropTypes.string
};

Thumbnail.defaultProps = {
  alt: '',
  imageUrl: '',
  productId: '',
  url: ''
};

export { Thumbnail };
