/* eslint-disable react/no-danger */
import React from 'react';
import PropTypes from 'prop-types';
import './General.scss';
import { CKEditor } from '@components/common/CKEditor';
import "../../../../Styles/Styles.scss";
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

export default function CategoryInfo({
  category: { name, description, image }
}) {
  return (
    <div className="container">
      <div className="mb-1 md:mb-2 category__general">
        {image && (
          <img src={image.url} alt={name} className="category__image" />
        )}
        <div className="category__info">
          <div>
            
            <div className="category__description font-24">
              <CKEditor content={description} />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

CategoryInfo.propTypes = {
  category: PropTypes.shape({
    name: PropTypes.string.isRequired,
    description: PropTypes.string.isRequired,
    image: PropTypes.shape({
      url: PropTypes.string.isRequired
    })
  }).isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 5
};

export const query = `
  query Query {
    category(id: getContextValue('categoryId')) {
      name
      description
      image {
        alt
        url
      }
    }
}`;
