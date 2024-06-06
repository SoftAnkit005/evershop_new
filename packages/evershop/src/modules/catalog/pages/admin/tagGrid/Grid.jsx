/* eslint-disable no-console */
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import SkuConditionSelector from '@components/admin/promotion/couponEdit/SkuConditionSelector';
import Button from '@components/common/form/Button';
import { _ } from '@evershop/evershop/src/lib/locale/translate';

function Grid() {
  const [selectedOption, setSelectedOption] = useState('');
  const [name, setName] = useState('');
  const [condition, setCondition] = useState({
    key: 'sku'

  })

  const handleTagSubmit = () => {
    console.log('condition ========================,', condition);
    console.log('name ========================,', name);
    console.log('selectedOption ========================,', selectedOption);
  }

  return (
    <div className="grid grid-cols-4 gap-1">
      <div className="card shadow p-2">
        <form id="tagForm">
          <div className="form-field-container">
            <div className="form-group mb-3">
              <p className='pb-1'>Name</p>
              <select className='form-control' value={selectedOption} onChange={(e) => setSelectedOption(e.target.value)}>
                <option value="Premium tag">Premium tag</option>
                <option value="Dr.Bwc Choice">Dr.Bwc Choice</option>
                <option value="Customize">Customize</option>
              </select>
            </div>
            {selectedOption === 'Customize' && (
              <div className="form-group mb-3">
                <p className='pb-1'>Name</p>
                <input
                  type="text"
                  name="name"
                  placeholder="Name"
                  className="form-control"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                />
              </div>
            )}
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
                onAction={handleTagSubmit}
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
