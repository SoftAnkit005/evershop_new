/* eslint-disable no-console */
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import SkuConditionSelector from '@components/admin/promotion/couponEdit/SkuConditionSelector';
import { Form } from '@components/common/form/Form';

function Grid({ action }) {
  const [selectedOption, setSelectedOption] = useState('');
  const [name, setName] = useState('');
  const [condition, setCondition] = useState({
    key: 'sku'
  });

  const [error, setError] = React.useState(null);

  const onSuccess = (response) => {
    if (response.success) {
      console.log('response success =========================================>', response);
      window.location.reload();
    } else {
      console.log('response success =========================================>', response);
      setError(response.message);
    }
  }

  return (
    <div className="grid grid-cols-4 gap-1">
      <div className="card shadow p-2">
        {error && <div className='error'>{error}</div>}
        <Form
          id="tagForm"
          method="POST"
          action={action}
          onSuccess={onSuccess}
        >
          <div className="form-field-container">
            <div className="form-group mb-3">
              <p className="pb-1">Name</p>
              <select className="form-control" value={selectedOption} onChange={(e) => setSelectedOption(e.target.value)}>
                <option value="Premium tag">Premium tag</option>
                <option value="Dr.Bwc Choice">Dr.Bwc Choice</option>
                <option value="Customize">Customize</option>
              </select>
            </div>
            {selectedOption === 'Customize' && (
              <div className="form-group mb-3">
                <p className="pb-1">Name</p>
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
              <p className="pb-1">Select Products</p>
              <SkuConditionSelector
                condition={condition}
                setCondition={setCondition}
              />
            </div>
          </div>
        </Form>
      </div>
    </div>
  );
}

// No longer marking `condition` as required, since it's managed within the component
Grid.propTypes = {
  action: PropTypes.string.isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 15
};

export const query = `
  query Query {
    action: url(routeId: "tagGrid")
  }
`


export default Grid;
