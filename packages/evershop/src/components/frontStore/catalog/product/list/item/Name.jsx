import { CKEditor } from '@components/common/CKEditor';
import PropTypes from 'prop-types';
import React from 'react';

function Name({ name, url, desc }) {
  return (
    <div className="pt-2 prodList">
      <a href={url} className='text-decoration-none'>
        <span className='font-16 text-dark prod-name'>{name}</span>
      </a>
      <div className='prod-desc'>
        <CKEditor content={desc} />
      </div>
    </div>
  );
}

Name.propTypes = {
  url: PropTypes.string,
  name: PropTypes.string,
  desc: PropTypes.string
};

Name.defaultProps = {
  url: '',
  name: '',
  desc: ''
};

export { Name };
