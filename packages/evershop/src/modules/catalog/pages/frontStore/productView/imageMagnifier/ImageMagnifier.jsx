import React, { useEffect, useRef, useState } from "react";
import './imageMagnifier.css'

function ImageMagnifier(props) {
    let img = document.getElementById("gfg-img"); 
    const zoomPreview = useRef(null)
    const gfgImg = useRef(null)
    
    const [ofsX, setofsX] = useState()
    const [ofsY, setofsY] = useState()
    useEffect(() => {
        if (zoomPreview.current) {
            setofsX(zoomPreview.current.offsetWidth / 100)
            setofsY(zoomPreview.current.offsetHeight / 100)
        }
        zoomPreview.current.style.display = "none";
    }, [])

    function mouseMove(e){
        const rect = gfgImg.current.getBoundingClientRect();
        const x = e.clientX - rect.left;
        zoomPreview.current.style.display = "block";
        zoomPreview.current.style.backgroundImage = `url(${props.imgsrc})`; 
        zoomPreview.current.style.backgroundSize = img.width * (ofsX / 2) + "px " + img.height * (ofsY / 2) + "px"; 
        let posX = e.clientX - rect.left; 
        let posY = e.clientY - rect.top; 
        zoomPreview.current.style.backgroundPosition = "-" + posX * (ofsX / 2) + "px -" + posY * (ofsY / 2) + "px"; 
    }

    function mouseOut(){
        zoomPreview.current.style.backgroundImage = "none";
        zoomPreview.current.style.display = "none";
    }
  return (
    <div className="magnify-main">
      <img src={props.imgsrc} onMouseMove={(e) => mouseMove(e)} onMouseOut={(e) => mouseOut(e)} ref={gfgImg} id="gfg-img" />
      <div className="zoom-preview" ref={zoomPreview} ></div>
    </div>
  );
}

export default ImageMagnifier;
