/* eslint-disable no-console */
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import SkuConditionSelector from '@components/admin/promotion/couponEdit/SkuConditionSelector';
import Button from '@components/common/form/Button';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

function Grid() {
  const [name, setName] = useState('')
  const [condition, setCondition] = useState({
    key: 'sku'

  })

  console.log('condition ========================,', condition, name);

  return (
    <div className="grid grid-cols-4 gap-1">
      <div className="card shadow p-2">
        <form id="tagForm">
          <div className="form-field-container">
            <div className="form-group mb-3">
              <p className='pb-1'>Name</p>
              <input type="text" name="name" placeholder="Name" className="form-control" value={name} onChange={(e) => setName(e.target.value)} />
            </div>
            <div className="form-group mb-3">
              <p className='pb-1'>Select Products</p>
              <SkuConditionSelector
                condition={condition}
                setCondition={setCondition}
              />
            </div>
            <div className="col-span-1">
              <Button
                title={_('Apply')}
                onAction={() => {
                  const tagForm = document.getElementById('tagForm');
                  if (tagForm) {
                    tagForm.dispatchEvent(
                      new Event('submit', { cancelable: true, bubbles: true })
                    );
                  } else {
                    console.error("Element with ID 'tagForm' not found.");
                  }
                }}
              />
            </div>
          </div>
        </form>
      </div>
    </div>
  );
}

Grid.propTypes = {
  condition: PropTypes.shape({
    key: PropTypes.string,
    name: PropTypes.string,
    value: PropTypes.oneOfType([
      PropTypes.arrayOf(PropTypes.string),
      PropTypes.string
    ])
  }).isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 15
};

export default Grid;
