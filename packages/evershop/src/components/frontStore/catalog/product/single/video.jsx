import PropTypes from 'prop-types';
import React from 'react';
import YouTube from 'react-youtube';

export function video({ video }) {


    const getVideoId = (url) => {
        const match = url.match(/[?&]v=([^&]+)/);
        return match ? match[1] : null;
    };

    const videoId = getVideoId(video);

    if (!videoId) {
        return null; // Render nothing if the URL is invalid
    }
    const opts = {
        width: '100%',
        height: '450',
        playerVars: {
            autoplay: 1
        }
    }

    return (

        <section className='related-products'>
            <div className='row align-items-center'>
                <div className='col-12'>
                    <h4 className="font-20 pb-0 text-brawn mb-4">Video</h4>
                    <YouTube opts={opts} videoId={videoId} />
                    <hr />
                </div>
            </div>
        </section>
    );
}

video.propTypes = {
    video: PropTypes.string.isRequired
};
