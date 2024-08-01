import PropTypes from 'prop-types';
import React, { useEffect, useState } from 'react';
import '@components/frontStore/catalog/product/list/item/Thumbnail.scss';
import ProductNoThumbnail from '@components/common/ProductNoThumbnail';
import axios from 'axios';
import { FaHeart, FaRegHeart } from 'react-icons/fa6';
import { toast } from 'react-toastify';


function Thumbnail({ url, imageUrl, alt, productId }) {
  // const [tag, setTag] = useState('');
  const [Wishlistclicked, setWishlistClicked] = useState(false);

  // useEffect(() => {
  //   async function getTag() {
  //     const tagData = await fetchTagData(productId);
      
  //     // if (tagData && tagData.name) {
  //     //   setTag(tagData.name);
  //     // } else {
  //     //   setTag('');
  //     // }
  //   }
  //   getTag();
  // }, [productId]);

  const handleClick = () => {
    if(Wishlistclicked){
      setWishlistClicked(false)
      toast("Removed from wishlist",{ autoClose: 2000 });
    } else {
      toast("Added to wishlist", { autoClose: 2000 });
      setWishlistClicked(true);
    }
  };

  return (
    <div className='card-body'>
      <button className={`position-absolute top-0 end-0 fs-2 p-4 text-danger pointer-event z-1 wishlist-button ${Wishlistclicked ? 'clicked' : ''}`} onClick={handleClick} >{(Wishlistclicked)?<FaHeart />:<FaRegHeart />}</button>
      {/* {tag && <p className='static-note'>{tag}</p>} */}
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



  
// async function fetchTagData(productId) {
//   try {
//     const response = await axios.get(`/api/getproducttag/0`);
//     console.log("tagData",response.data);
//     return response.data;
//   } catch (error) {
//     console.error('Error fetching tag data:', error);
//     return null;
//   }
// }

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
