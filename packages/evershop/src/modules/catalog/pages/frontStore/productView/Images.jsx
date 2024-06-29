/* eslint-disable jsx-a11y/anchor-is-valid */
/* eslint-disable react/no-array-index-key */
import ProductNoThumbnail from '@components/common/ProductNoThumbnail';
import PropTypes from 'prop-types';
import React from 'react';
import "../../../../Styles/Styles.scss"
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../categoryView/Index.scss"
import YouTube from 'react-youtube';

function Current({ image }) {


  return (
    <div
      id="product-current-image"
      style={{ background: '#f6f6f6' }}
      className="product-image product-single-page-image flex justify-center items-center w-100"
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

export default function Images({ product: { uuid, video, image, gallery = [] } }) {
  const [current, setCurrent] = React.useState(image);
  const [thumbs, setThumbs] = React.useState(gallery);



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


  const getVideoId = (url) => {
    const match = url.match(/[?&]v=([^&]+)/);
    return match ? match[1] : null;
  };
  const opts = {
    width: '100%',
    height: '450',
    playerVars: {
      autoplay: 1
    }
  }
  const videoId = getVideoId(video);

  return (
    <>
      <div className="product-single-media position-relative">
        <ul className="more-view-thumbnail product-gallery">
          {thumbs.map((i, j) => (
            <li key={j} className="flex justify-center items-center mb-3 border-theme-brown">
              <a
                href="#"
                onClick={(e) => {
                  e.preventDefault();
                  setCurrent({ ...i });
                }}
                className="p-4"
              >
                <img className="self-center" src={i.thumb} alt={i.alt} />
              </a>
            </li>
          ))}
        </ul>
        <Current image={current} />
      </div>
      {(!videoId) ?
        <></>
        :
        <section className='related-products me-lg-3 me-md-0'>
          <div className='row align-items-center'>
            <div className='col-12'>
              {/* <h4 className="font-20 pb-0 text-brawn mb-4">Video</h4> */}
              <YouTube opts={opts} videoId={videoId} />
            </div>
          </div>
        </section>
      }
    </>
  );
}

Images.propTypes = {
  product: PropTypes.shape({
    uuid: PropTypes.string.isRequired,
    video: PropTypes.string.isRequired,
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
        product(id: getContextValue('productId')) {
        uuid
      video
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
