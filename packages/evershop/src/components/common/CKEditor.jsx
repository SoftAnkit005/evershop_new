/* eslint-disable react/no-danger */
import PropTypes from 'prop-types';
import React from 'react';
import './CKEditor.scss';


export function CKEditor({ content }) {
  return (
    <div className="ck-content font-14 mt-4" style={{ color: '#101010', fontWeight: 400 }}>
      <div dangerouslySetInnerHTML={{ __html: content }} />
    </div>

  );
}

CKEditor.propTypes = {
  content: PropTypes.string
};

CKEditor.defaultProps = {
  content: ''
};
