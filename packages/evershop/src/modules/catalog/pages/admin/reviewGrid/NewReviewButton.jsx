import PropTypes from 'prop-types';
import React from 'react';
import Button from '@components/common/form/Button';
import "../../../../Styles/Index.scss"

export default function NewReviewButton({ newReviewUrl }) {
  return <Button url={newReviewUrl} title="New Review" />;
}

NewReviewButton.propTypes = {
  newReviewUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'pageHeadingRight',
  sortOrder: 10
};

export const query = `
  query Query {
    newReviewUrl: url(routeId: "reviewNew")
  }
`;
