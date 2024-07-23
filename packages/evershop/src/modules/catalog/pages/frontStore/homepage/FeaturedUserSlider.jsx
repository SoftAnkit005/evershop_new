
import React from 'react';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import "../../../../Styles/Styles.scss";
import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import YouTube from 'react-youtube';
import './FeaturedUserSlider.scss'


export default function FeaturedUserSlider() {

    const settings = {
        infinite: true,
        arrows: false,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: true,
        speed: 2500,
        autoplaySpeed: 2500,
        cssEase: "linear",
        responsive: [
            {
                breakpoint: 575,
                settings: {
                    slidesToShow: 1
                }
            },
            {
                breakpoint: 767,
                settings: {
                    slidesToShow: 2
                }
            },
            {
                breakpoint: 1199,
                settings: {
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 1440,
                settings: {
                    slidesToShow: 3
                }
            }
        ]
    };


    
    const getVideoId = (url) => {
        const match = url.match(/[?&]v=([^&]+)/);
        return match ? match[1] : null;
    };
    const opts = {
        width: '100%',
        height: '250px',
        playerVars: {
          autoplay: 1,
          controls: 1,
          showinfo: 0, // Deprecated, use below parameters
          modestbranding: 1, // This will remove the YouTube logo
          rel: 0, // This will disable related videos at the end
          fs: 1, // Enable full screen button
          iv_load_policy: 3, // Disable annotations
          disablekb: 1, // Disable keyboard controls
          cc_load_policy: 0, // Disable closed captions
          branding: 0, // Branding to false
        },
    }
 
    function videoOnEnd(event) {
        event.target.playVideo(); // Loop the video
    }


    return (
        <section className='accreditation bg-transparent'>
            <div className='container'>
                <div className='text-center'>
                    <h3 className='products-subtitle-black text-uppercase mb-5'>User Slider</h3>
                </div>
                <div className='accreditation-item user-slider'>
                    <Slider {...settings}>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=LqVvZt2b9LI")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=3P0dPjB7YFA")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=I_XQpm1dycs")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=-fuQvzGJ6ro")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=ILHvXl10bRk")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=-sH21FadQKQ")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=LG1FB6oFoV4")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=yGHMgdC4a0M")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=LqVvZt2b9LI")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                        <div className='accreditation-image position-relative'>
                            <YouTube opts={opts} videoId={getVideoId("https://www.youtube.com/watch?v=3P0dPjB7YFA")} onEnd={() => videoOnEnd(e)}/>
                        </div>
                    </Slider>
                </div>
            </div>
        </section>
    );
}
export const layout = {
    areaId: 'content',
    sortOrder: 15
};