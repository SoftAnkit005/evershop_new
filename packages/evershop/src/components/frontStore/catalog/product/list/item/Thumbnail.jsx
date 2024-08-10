import PropTypes from "prop-types";
import React, { useEffect, useState } from "react";
import "@components/frontStore/catalog/product/list/item/Thumbnail.scss";
import ProductNoThumbnail from "@components/common/ProductNoThumbnail";
import axios from "axios";
import { FaHeart, FaRegHeart } from "react-icons/fa6";
import { toast } from "react-toastify";

function Thumbnail({ url, imageUrl, alt, productId, tags, listType, account }) {
  const [Wishlistclicked, setWishlistClicked] = useState(false);

  useEffect(() => {
    account?.wishlistedProducts.items.map((item) => (item === productId)?setWishlistClicked(true):console.log(false))
  }, [])
  


  const handleClick = async () => {
    if (!account) {
      toast("Please log in to add items to your wishlist", {
        autoClose: 2000
      });
      return;
    }
    const userId = account?.customerId.toString();
    const baseUrl = `${window.location.protocol}//${window.location.host}`;
    const apiUrl = `${baseUrl}/api/wishlistdata`;
    try {
      const response = await axios.post(
        apiUrl,
        {
          user_id: userId,
          product_id: productId
        },
        {
          headers: {
            "Content-Type": "application/json"
          }
        }
      );
      if (response.status === 200) {
        setWishlistClicked(!Wishlistclicked);
        toast(Wishlistclicked ? "Removed from wishlist" : "Added to wishlist", {
          autoClose: 2000
        });
      } else {
        toast("Failed to update wishlist", { autoClose: 2000 });
      }
    } catch (error) {
      toast("An error occurred while updating the wishlist", {
        autoClose: 2000
      });
    }
  };

  return (
    <div className="card-body">
      {listType === "wishlist" ? (
        <>
          <a href="#"
            className={`position-absolute top-0 end-0 fs-2 p-4 text-danger pointer-event z-1 wishlist-button ${
              Wishlistclicked ? "clicked" : ""
            }`}
            onClick={handleClick}
          >
            {Wishlistclicked ? <FaHeart /> : <FaRegHeart />}
          </a>
        </>
      ) : (
        <button
          className={`position-absolute top-0 end-0 fs-2 p-4 text-danger pointer-event z-1 wishlist-button ${
            Wishlistclicked ? "clicked" : ""
          }`}
          onClick={handleClick}
        >
          {Wishlistclicked ? <FaHeart /> : <FaRegHeart />}
        </button>
      )}
      {tags?.items.map((items) =>
        items.productId === productId ? (
          <p className="static-note">{items.name}</p>
        ) : (
          <></>
        )
      )}
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

Thumbnail.propTypes = {
  alt: PropTypes.string,
  imageUrl: PropTypes.string,
  productId: PropTypes.string,
  url: PropTypes.string,
};

Thumbnail.defaultProps = {
  alt: "",
  imageUrl: "",
  productId: "",
  url: "",
};

export { Thumbnail };
