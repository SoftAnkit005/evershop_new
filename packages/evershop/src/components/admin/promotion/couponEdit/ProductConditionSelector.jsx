// SkuConditionSelector.jsx

import PropTypes from 'prop-types';
import React, { useState } from 'react';
import { useModal } from '@components/common/modal/useModal';
import ProductSelector from '@components/admin/promotion/couponEdit/ProductSelector';

export default function ProductConditionSelector({
  condition,
  setCondition
  // isMulti
}) {
  const productIds = Array.isArray(condition.value) ? condition.value : [];
  const [selectedProducts, setSelectedProducts] = useState(productIds || []);
  const modal = useModal();

  const closeModal = () => {
    modal.closeModal();
  };

  const onSelect = (productId) => {
    setSelectedProducts([productId]);
    // if (!isMulti) {
    //   return;
    // }
    // setSelectedSKUs([sku, ...selectedSKUs]);
  };

  const onUnSelect = (productId) => {
    setSelectedProducts(selectedProducts.filter((p) => p !== productId));
  };

  React.useEffect(() => {
    setCondition({
      ...condition,
      value: selectedProducts
    });
  }, [selectedProducts]);

  if (condition.key !== 'productId') {
    return null;
  }

  return (
    <div>
      <a
        href="#"
        className="text-interactive hover:underline"
        onClick={(e) => {
          e.preventDefault();
          modal.openModal();
        }}
      >
        {selectedProducts.map((productId, index) => (
          <span key={productId}>
            {index === 0 && <span className="italic">&lsquo;{productId}&rsquo;</span>}
            {index === 1 && <span> and {selectedProducts.length - 1} more</span>}
          </span>
        ))}
        {selectedProducts.length === 0 && <span>Choose Products</span>}
      </a>
      {modal.state.showing && (
        <div className={modal.className} onAnimationEnd={modal.onAnimationEnd}>
          <div
            className="modal-wrapper flex self-center justify-center items-center"
            tabIndex={-1}
            role="dialog"
          >
            <div className="modal">
              <ProductSelector
                onSelect={onSelect}
                onUnSelect={onUnSelect}
                selectedChecker={({ productId }) => selectedProducts.includes(productId)}
                closeModal={closeModal}
              />
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

ProductConditionSelector.propTypes = {
  condition: PropTypes.shape({
    key: PropTypes.string,
    value: PropTypes.oneOfType([
      PropTypes.arrayOf(PropTypes.string),
      PropTypes.string
    ])
  }).isRequired,
  setCondition: PropTypes.func.isRequired
  // isMulti: PropTypes.bool
};

// SkuConditionSelector.defaultProps = {
//   isMulti: true
// };

export const layout = {
  areaId: 'couponProductConditionValue',
  sortOrder: 15
};
