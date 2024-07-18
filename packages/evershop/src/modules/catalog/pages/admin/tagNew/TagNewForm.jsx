/* eslint-disable no-console */
import React, { useState } from 'react';
import PropTypes from 'prop-types';
// import SkuConditionSelector from '@components/admin/promotion/couponEdit/SkuConditionSelector';
import ProductConditionSelector from '@components/admin/promotion/couponEdit/ProductConditionSelector';
import { Form } from '@components/common/form/Form';
import { toast } from 'react-toastify';

function Grid({ action }) {
  const [selectedOption, setSelectedOption] = useState('');
  const [name, setName] = useState('');
  const [condition, setCondition] = useState({
    key: 'productId'
  });

  const [error, setError] = React.useState(null);

  const onSuccess = async () => {
    const result = await fetch(" https://drbwc.com/api/tagdata ", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        "name": name,
        "product_id": condition.value[0]
      })
    });
    const data = await result.json();
    console.log(data)
    if (data.success) {
      console.log('response success =========================================>', data);
      toast.success('Tag added successfully!')
      location.replace("https://drbwc.com/admin/tag")
    } else {
      console.log('response error =========================================>', data);
      toast.error('Something wrong. Please reload the page!')
      setError(data.message);
    }
  }
  console.log(action)
  return (
    <div className="grid grid-cols-4 gap-1">
      <div className="card shadow p-2">
        {error && <div className='error'>{error}</div>}
        <Form
          id="tagForm"
          // method="POST"
          action="/api/tagdata"
          onSuccess={onSuccess}
        >
          <div className="form-field-container">
            <div className="form-group mb-3">
              <p className="pb-1">Tag Name</p>
              <input
                type="text"
                name="name"
                placeholder="Name"
                className="form-control"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </div>

            <div className="form-group mb-3">
              <p className="pb-1">Select Products</p>
              <ProductConditionSelector
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
