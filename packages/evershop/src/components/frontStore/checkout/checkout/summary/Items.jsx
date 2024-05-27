import PropTypes from 'prop-types';
import React from 'react';
import './Items.scss';
import ProductNoThumbnail from '@components/common/ProductNoThumbnail';
import "../../../../../modules/Styles/Styles.scss";  
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min';

function ItemVariantOptions({ options = [] }) {
  if (!Array.isArray(options) || !options || options.length === 0) {
    return null;
  }

  return (
    <div className="cart-item-variant-options mt-05">
      <ul>
        {options.map((o, i) => (
          // eslint-disable-next-line react/no-array-index-key
          <li key={i}>
            <span className="attribute-name">{o.attribute_name}: </span>
            <span>{o.option_text}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

ItemVariantOptions.propTypes = {
  options: PropTypes.arrayOf(
    PropTypes.shape({
      attribute_name: PropTypes.string,
      option_text: PropTypes.string
    })
  )
};

ItemVariantOptions.defaultProps = {
  options: []
};

function Items({ items, displayCheckoutPriceIncludeTax }) {
  return (
    <div id="summary-items">
      <div className='order-item'>
          <div >
          {items.map((item, index) => (
            // eslint-disable-next-line react/no-array-index-key
            <div key={index} className="order-list justify-content-start align-items-center" >             
              <div className="product-thumbnail">
                <div className="thumbnail">
                  {item.thumbnail && (
                    <img src={item.thumbnail} alt={item.productName} />
                  )}
                  {!item.thumbnail && (
                    <ProductNoThumbnail width={45} height={45} />
                  )}
                </div>
                <span className="qty">{item.qty}</span>
              </div>
              <div className='order-price'>
                <div className="product-column">
                  <span className="products-name">{item.productName}</span>
                  <ItemVariantOptions
                    options={JSON.parse(item.variantOptions || '[]')}
                  />
                </div>
                <span>
                  {displayCheckoutPriceIncludeTax
                    ? item.total.text
                    : item.subTotal.text}
                </span>
              </div>                         
            </div>
          ))} 
        </div> 
      </div>     
    </div>
  );
}

Items.propTypes = {
  items: PropTypes.arrayOf(
    PropTypes.shape({
      thumbnail: PropTypes.string,
      productName: PropTypes.string,
      variantOptions: PropTypes.string,
      qty: PropTypes.number,
      total: PropTypes.shape({
        text: PropTypes.string
      }),
      subTotal: PropTypes.shape({
        text: PropTypes.string
      })
    })
  ),
  displayCheckoutPriceIncludeTax: PropTypes.bool
};

Items.defaultProps = {
  items: [],
  displayCheckoutPriceIncludeTax: false
};

export { Items };
