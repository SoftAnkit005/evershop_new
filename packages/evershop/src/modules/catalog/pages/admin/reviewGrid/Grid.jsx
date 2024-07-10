/* eslint-disable react/no-unstable-nested-components */
import PropTypes from 'prop-types';
import React, { useState } from 'react';
import axios from 'axios';
import Area from '@components/common/Area';
import Pagination from '@components/common/grid/Pagination';
import { Checkbox } from '@components/common/form/fields/Checkbox';
import { useAlertContext } from '@components/common/modal/Alert';
import ProductNameRow from '@components/admin/catalog/productGrid/rows/ProductName';
import { Card } from '@components/admin/cms/Card';
import SortableHeader from '@components/common/grid/headers/Sortable';
import { Form } from '@components/common/form/Form';
import { Field } from '@components/common/form/Field';
import "../../../../Styles/Index.scss"

function Actions({ reviews = [], selectedIds = [] }) {
  const { openAlert, closeAlert } = useAlertContext();
  const [isLoading, setIsLoading] = useState(false);

  const deleteReviews = async () => {
    setIsLoading(true);
    const promises = reviews
      .filter((review) => selectedIds.includes(review.id))
      .map((review) => axios.delete(review.deleteApi));
    await Promise.all(promises);
    setIsLoading(false);
    // Refresh the page
    window.location.reload();
  };

  const actions = [
    {
      name: 'Delete',
      onAction: () => {
        openAlert({
          heading: `Delete ${selectedIds.length} reviews`,
          content: <div>Can&apos;t be undone</div>,
          primaryAction: {
            title: 'Cancel',
            onAction: closeAlert,
            variant: 'primary'
          },
          secondaryAction: {
            title: 'Delete',
            onAction: async () => {
              await deleteReviews();
            },
            variant: 'critical',
            isLoading
          }
        });
      }
    }
  ];

  return (
    <tr>
      {selectedIds.length === 0 && null}
      {selectedIds.length > 0 && (
        <td style={{ borderTop: 0 }} colSpan="100">
          <div className="inline-flex border border-divider rounded justify-items-start">
            <a href="#" className="font-semibold pt-075 pb-075 pl-15 pr-15">
              {selectedIds.length} selected
            </a>
            {actions.map((action) => (
              <a
                href="#"
                onClick={(e) => {
                  e.preventDefault();
                  action.onAction();
                }}
                className="font-semibold pt-075 pb-075 pl-15 pr-15 block border-l border-divider self-center"
              >
                <span>{action.name}</span>
              </a>
            ))}
          </div>
        </td>
      )}
    </tr>
  );
}

Actions.propTypes = {
  selectedIds: PropTypes.arrayOf(PropTypes.number).isRequired,
  reviews: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      deleteApi: PropTypes.string.isRequired
    })
  ).isRequired
};

export default function ReviewGrid({
  reviews: { items: reviews, total, currentFilters = [] }
}) {
  const page = currentFilters.find((filter) => filter.key === 'page')
    ? currentFilters.find((filter) => filter.key === 'page').value
    : 1;

  const limit = currentFilters.find((filter) => filter.key === 'limit')
    ? currentFilters.find((filter) => filter.key === 'limit').value
    : 20;
  const [selectedRows, setSelectedRows] = useState([]);

  return (
    <Card>
      <Card.Session
        title={
          <Form submitBtn={false}>
            <Field
              type="text"
              id="keyword"
              placeholder="Search"
              value={currentFilters.find((f) => f.key === 'keyword')?.value}
              onKeyPress={(e) => {
                // If the user press enter, we should submit the form
                if (e.key === 'Enter') {
                  const url = new URL(document.location);
                  const keyword = document.getElementById('keyword')?.value;
                  if (keyword) {
                    url.searchParams.set('keyword', keyword);
                  } else {
                    url.searchParams.delete('keyword');
                  }
                  window.location.href = url;
                }
              }}
            />
          </Form>
        }
        actions={[
          {
            variant: 'interactive',
            name: 'Clear filter',
            onAction: () => { }
          }
        ]}
      />
      <table className="listing sticky category">
        <thead>
          <tr>
            <th className="text-center" aria-label="Select all review">
              <Checkbox
                onChange={(e) => {
                  if (e.target.checked) {
                    setSelectedRows(reviews.map((r) => r.id));
                  } else {
                    setSelectedRows([]);
                  }
                }}
              />
            </th>
            <Area
              id="productGridHeader"
              noOuter
              coreComponents={[
                {
                  component: {
                    default: () => (
                      <SortableHeader
                        title="Name"
                        name="name"
                        currentFilters={currentFilters}
                      />
                    )
                  },
                  sortOrder: 10
                }
              ]}
            />
            <Area
              id="productGridHeader"
              noOuter
              coreComponents={[
                {
                  component: {
                    default: () => (
                      <SortableHeader
                        title="Review"
                        name="view"
                        currentFilters={currentFilters}
                      />
                    )
                  },
                  sortOrder: 10
                }
              ]}
            />
          </tr>
        </thead>
        <tbody className="text-center">
          <Actions
            reviews={reviews}
            selectedIds={selectedRows}
            setSelectedRows={setSelectedRows}
          />
          {reviews.map((r) => (
            <tr key={r.id}>
              <td aria-label={`Select review with ID ${r.id}`}>
                <Checkbox
                  isChecked={selectedRows.includes(r.id)}
                  onChange={(e) => {
                    if (e.target.checked) {
                      setSelectedRows(selectedRows.concat([r.id]));
                    } else {
                      setSelectedRows(
                        selectedRows.filter((row) => row !== r.id)
                      );
                    }
                  }}
                />
              </td>
              <Area
                id="productGridRow"
                row={r}
                noOuter
                selectedRows={selectedRows}
                setSelectedRows={setSelectedRows}
                coreComponents={[
                  {
                    component: {
                      default: () => (
                        <ProductNameRow
                          id="name"
                          name={r.name}
                        />
                      )
                    },
                    sortOrder: 10
                  }
                ]}
              />
              <Area
                id="productGridRow"
                row={r}
                noOuter
                selectedRows={selectedRows}
                setSelectedRows={setSelectedRows}
                coreComponents={[
                  {
                    component: {
                      default: () => (
                        <ProductNameRow
                          id="view"
                          name={r.view}
                        />
                      )
                    },
                    sortOrder: 10
                  }
                ]}
              />
            </tr>
          ))}
        </tbody>
      </table>
      {reviews.length === 0 && (
        <div className="flex w-full justify-center">
          There is no product review to display
        </div>
      )}
      <Pagination total={total} limit={limit} page={page} />
    </Card>
  );
}

ReviewGrid.propTypes = {
  reviews: PropTypes.shape({
    items: PropTypes.arrayOf(
      PropTypes.shape({
        id: PropTypes.string,
        name: PropTypes.string,
        view: PropTypes.string
      })
    ),
    total: PropTypes.number,
    currentFilters: PropTypes.arrayOf(
      PropTypes.shape({
        key: PropTypes.string,
        operation: PropTypes.string,
        value: PropTypes.string
      })
    )
  }).isRequired
};

export const layout = {
  areaId: 'content',
  sortOrder: 20
};

export const query = `
  query Reviews($filters: [FilterInput]) {
    reviews (filters: $filters) {
      items {
        id
        name
        view
        deleteApi
      }
      total
      currentFilters {
        key
        operation
        value
      }
    }
    newReviewUrl: url(routeId: "reviewNew")
  }
`;


export const variables = `
{
  filters: getContextValue('filtersFromUrl')
}`;
