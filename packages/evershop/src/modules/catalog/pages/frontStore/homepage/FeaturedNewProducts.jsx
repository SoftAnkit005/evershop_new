import NewHomeProductList from '@components/frontStore/catalog/product/list/NewHomeProductList';
import React from 'react';

export default function FeaturedNewProducts() {
  const collection = [
    {
      "productId": 1,
      "name": "Massage Chair",
      "productDetails": "Elegantly Luxurious",
      "companydetails": "Refexology foot plate with a very gentle vibration mode, 3 relaxing speeds.",
      "image": { "alt": "Black Onyx", "url": "Assets/Images/foot_massage_one.png" },
      "url": "/massage-chair"
    },
    {
      "productId": 2,
      "name": "MASSAGE BEDS",
      "productDetails": "Elegantly Luxurious",
      "companydetails": "Refexology foot plate with a very gentle vibration mode, 3 relaxing speeds.",
      "image": { "alt": "Foot Massage", "url": "Assets/Images/massage_bed.png" },
      "url": "thermal-heating-bed"
    },
    {
      "productId": 3,
      "name": "FOOT MASSAGE",
      "productDetails": "Elegantly Luxurious",
      "companydetails": "Refexology foot plate with a very gentle vibration mode, 3 relaxing speeds.",
      "image": { "alt": "Foot Massage", "url": "Assets/Images/foot_massage_two.png" },
      "url": "/thermal-heating-bed/foot-massage"
    },
    {
      "productId": 4,
      "name": "NECK & SHOULDER MASSAGER",
      "productDetails": "Elegantly Luxurious",
      "companydetails": "Refexology foot plate with a very gentle vibration mode, 3 relaxing speeds.",
      "image": {
        "alt": "Foot Massage",
        "url": "Assets/Images/Neck_Shoulder_Massager.png"
      },
      "url": "/thermal-heating-bed/foot-massage"
    },
    {
      "productId": 5,
      "name": "JACUZZI HOT TUB",
      "productDetails": "Elegantly Luxurious",
      "companydetails": "Refexology foot plate with a very gentle vibration mode, 3 relaxing speeds.",
      "image": {
        "alt": "Foot Massage",
        "url": "Assets/Images/jacuzzi_hot_tub.png"
      },
      "url": "/salon-spa-jacuzzi"
    },
    {
      "productId": 6,
      "name": "HEAD & EYE MASSAGER",
      "productDetails": "Elegantly Luxurious",
      "companydetails": "Refexology foot plate with a very gentle vibration mode, 3 relaxing speeds.",
      "image": {
        "alt": "Foot Massage",
        "url": "Assets/Images/Head_Eye_Massager.png"
      },
      "url": "/thermal-heating-bed/foot-massage"
    }
  ]

  return (
    <div className="">
      <div className="products col-11 col-xxl-8 col-md-10 m-auto">
        <h3 className="fae-head">
          <span>DR.BWC </span>
          MASSAGE CHAIRS ARE EQUIPPED
          WITH STATE OF THE ART TECHNOLOGY.
        </h3>
        <p className="font-14 text-center m-auto text-dark text-uppercase">Experience the DR.BWC range of SL-Track massage chairs. DR.BWC offers a massage chair that suits all body types and curves. Check out how DR.BWC redefines comfort with luxury.</p>

        <NewHomeProductList products={collection} />
      </div>
    </div>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
