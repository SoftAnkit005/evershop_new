/* eslint-disable react/button-has-type */
import PropTypes from 'prop-types';
import React from 'react';
import './Button.scss';
import "../../../modules/Styles/Index.scss"

function Button({
  title,
  outline = false,
  variant = 'primary',
  onAction,
  url = undefined,
  isLoading = false,
  type = 'button'
}) {
  const className = ['btn-brown mt-4', variant];
  if (outline === true) className.push('outline');
  if (isLoading === true) className.push('loading');
  className.push('btn-white');

  const onActionFunc = (e) => {
    e.preventDefault();
    if (isLoading === true) return;
    onAction.call();
  };
  if (!url) {
    return (
      <button
        type={type}
        onClick={(e) => {
          onActionFunc(e);
        }}
        className={className.join(' ')}
      >
        {(isLoading === true)?
          <svg
            style={{
              background: 'rgb(255, 255, 255, 0)',
              display: 'block',
              shapeRendering: 'auto'
            }}
            width="2rem"
            height="2rem"
            viewBox="0 0 100 100"
            preserveAspectRatio="xMidYMid"
          >
            <circle
              cx="50"
              cy="50"
              fill="none"
              stroke="#fff"
              strokeWidth="10"
              r="43"
              strokeDasharray="202.63272615654165 69.54424205218055"
            >
              <animateTransform
                attributeName="transform"
                type="rotate"
                repeatCount="indefinite"
                dur="1s"
                values="0 50 50;360 50 50"
                keyTimes="0;1"
              />
            </circle>
          </svg>
          :
        <span>{title}</span>
        }
        {/* {isLoading === true && (
        )} */}
      </button>
    );
  } else {
    return (
      <a href={url} className={className.join(' ')}>
        <span>{title}</span>
      </a>
    );
  }
}

Button.propTypes = {
  isLoading: PropTypes.bool,
  onAction: PropTypes.func,
  outline: PropTypes.bool,
  title: PropTypes.oneOfType([PropTypes.string, PropTypes.node]).isRequired,
  url: PropTypes.string,
  variant: PropTypes.string,
  type: PropTypes.string
};

Button.defaultProps = {
  isLoading: false,
  onAction: undefined,
  outline: false,
  url: undefined,
  variant: 'primary',
  type: 'button'
};

export default Button;
