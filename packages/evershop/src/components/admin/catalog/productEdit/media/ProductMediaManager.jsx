/* eslint-disable jsx-a11y/label-has-associated-control */
/* eslint-disable jsx-a11y/no-static-element-interactions */
/* eslint-disable jsx-a11y/click-events-have-key-events */
/* eslint-disable no-undef */
import PropTypes from 'prop-types';
import React, { useState, useEffect } from 'react';
import uniqid from 'uniqid';
import { toast } from 'react-toastify';
import { get } from '@evershop/evershop/src/lib/util/get';
import './ProductMediaManager.scss';
import Spinner from '@components/common/Spinner';

function Upload({ addImage, productImageUploadUrl }) {
  const [uploading, setUploading] = React.useState(false);
  const [finalURL, setFinalURL] = useState('');

  const onChange = (e) => {
    setUploading(true);
    e.persist();
    const formData = new FormData();
    for (let i = 0; i < e.target.files.length; i += 1) {
      formData.append('images', e.target.files[i]);
    }
    const targetPath = `catalog/${Math.floor(Math.random() * (9999 - 1000)) + 1000
      }/${Math.floor(Math.random() * (9999 - 1000)) + 1000}`;
    formData.append('targetPath', targetPath);
    fetch(productImageUploadUrl + targetPath, {
      method: 'POST',
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
      .then((response) => {
        if (
          !response.headers.get('content-type') ||
          !response.headers.get('content-type').includes('application/json')
        ) {
          throw new TypeError('Something wrong. Please try again');
        }

        return response.json();
      })
      .then((response) => {
        if (!response.error) {
          addImage(
            get(response, 'data.files', []).map((i) => ({
              id: uniqid(),
              url: i.url,
              path: i.path
            }))
          );
        } else {
          toast.error(get(response, 'error.message', 'Failed!'));
        }
      })
      .catch((error) => {
        toast.error(error.message);
      })
      .finally(() => {
        e.target.value = null;
        setUploading(false);
      });
  };

  useEffect(() => {
    const currentURL = window.location.href;
    const newURL = currentURL.replace(currentURL, '');
    const pathStartIndex = newURL.indexOf('/', 8);
    const newPath = newURL.substring(pathStartIndex);
    const finalURL = window.location.origin + newPath;
    setFinalURL(finalURL);
  }, []);

  const id = uniqid();
  return (
    <div className="uploader grid-item">
      <div className="uploader-icon">
        <label htmlFor={id}>
          {uploading ? (
            <Spinner width={25} height={25} />
          ) : (
            <img src={`${finalURL}/Assets/Images/upload_image.svg`} alt='Upload' className='upload_img' />
          )}
        </label>
      </div>
      <div className="invisible">
        <input id={id} type="file" multiple onChange={onChange} />
      </div>
    </div>
  );
}

Upload.propTypes = {
  addImage: PropTypes.func.isRequired,
  productImageUploadUrl: PropTypes.string.isRequired
};

function Image({ image, removeImage }) {
  return (
    <div className="image grid-item" id={image.id}>
      <div className="img">
        <img src={image.url} alt="" />
      </div>
      <span
        className="remove cursor-pointer text-critical fill-current"
        onClick={() => removeImage(image.id)}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="16"
          height="16"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          strokeLinecap="round"
          strokeLinejoin="round"
          className="feather feather-trash-2"
        >
          <polyline points="3 6 5 6 21 6" />
          <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2" />
          <line x1="10" y1="11" x2="10" y2="17" />
          <line x1="14" y1="11" x2="14" y2="17" />
        </svg>
      </span>
    </div>
  );
}

Image.propTypes = {
  image: PropTypes.shape({
    id: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired
  }).isRequired,
  removeImage: PropTypes.func.isRequired
};

function Images({ id, images, addImage, removeImage, productImageUploadUrl }) {
  return (
    <div id={id} className="image-list">
      {images.map((image) => (
        <Image key={image.id} removeImage={removeImage} image={image} />
      ))}
      <Upload
        addImage={addImage}
        productImageUploadUrl={productImageUploadUrl}
      />
    </div>
  );
}

Images.propTypes = {
  addImage: PropTypes.func.isRequired,
  id: PropTypes.string.isRequired,
  images: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.string
    })
  ).isRequired,
  removeImage: PropTypes.func.isRequired,
  productImageUploadUrl: PropTypes.string.isRequired
};

async function loadSwappable() {
  const { Swappable } = await import('@shopify/draggable');
  return Swappable;
}

export default function ProductMediaManager({
  productImages = [],
  id,
  productImageUploadUrl
}) {
  const [images, setImages] = React.useState(productImages);
  const [draggable, setDragable] = React.useState(null);

  React.useEffect(() => {
    async function initSwappable() {
      if (draggable) {
        draggable.destroy();
      }

      const Swappable = await loadSwappable();
      // eslint-disable-next-line new-cap
      const swappable = new Swappable(document.querySelectorAll(`div#${id}`), {
        draggable: 'div.image',
        handle: 'div.image img'
      });
      let source = null;
      let destination = null;
      swappable.on('swappable:swapped', (event) => {
        source = event.data.dragEvent.data.source.id;
        destination = event.data.dragEvent.data.over.id;
      });

      swappable.on('swappable:stop', () => {
        if (!source || !destination) {
          return;
        }
        setImages((originImages) => {
          const newImages = Array.from(originImages);
          const sr = originImages.find((image) => image.id === source);
          newImages[originImages.findIndex((image) => image.id === source)] =
            originImages.find((image) => image.id === destination);
          newImages[
            originImages.findIndex((image) => image.id === destination)
          ] = sr;
          return newImages;
        });
      });
      setDragable(swappable);
    }
    initSwappable();
  }, [images]);

  const addImage = (imageArray) => {
    if (draggable) {
      draggable.destroy();
    }
    setImages(images.concat(imageArray));
  };

  const removeImage = (imageId) => {
    if (draggable) {
      draggable.destroy();
    }
    setImages(images.filter((i) => i.id !== imageId));
  };

  return (
    <div className="product-image-manager">
      <Images
        id={id}
        images={images}
        addImage={addImage}
        removeImage={removeImage}
        productImageUploadUrl={productImageUploadUrl}
      />
      {images.map((image) => (
        <input
          key={image.id}
          type="hidden"
          name={`${id}[]`}
          value={image.url}
        />
      ))}
    </div>
  );
}

ProductMediaManager.propTypes = {
  id: PropTypes.string.isRequired,
  productImages: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.string,
      src: PropTypes.string
    })
  ).isRequired,
  productImageUploadUrl: PropTypes.string.isRequired
};
