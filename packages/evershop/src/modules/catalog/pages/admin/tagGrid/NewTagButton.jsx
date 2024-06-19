import PropTypes from 'prop-types';
import React from 'react';
import Button from '@components/common/form/Button';
import "../../../../Styles/Index.scss"

export default function NewTagButton({ newTagUrl }) {
  return <Button url={newTagUrl} title="New Tag" />;
}

NewTagButton.propTypes = {
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
