import PropTypes from 'prop-types';
import React from 'react';
import Button from '@components/common/form/Button';
import "../../../../Styles/Index.scss"

export default function NewDocButton({ newTagUrl }) {
  return <Button url={newTagUrl} title="New Tag" />;
}

NewDocButton.propTypes = {
  newTagUrl: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'pageHeadingRight',
  sortOrder: 10
};

export const query = `
  query Query {
    newTagUrl: url(routeId: "tagNew")
  }
`;
