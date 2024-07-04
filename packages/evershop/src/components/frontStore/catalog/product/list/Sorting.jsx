/* eslint-disable jsx-a11y/anchor-is-valid */
/* eslint-disable no-restricted-globals */
import React from 'react';
import { Select } from '@components/common/form/fields/Select';
import { useAppDispatch } from '@components/common/context/app';
import { _ } from '@evershop/evershop/src/lib/locale/translate';
import options from '@components/frontStore/catalog/product/list/SortOptions';
import { IoArrowUpOutline, IoArrowDownOutline } from "react-icons/io5";

export default function Sorting() {
  const AppContextDispatch = useAppDispatch();
  const [sortBy, setSortBy] = React.useState(() => {
    // Check if this is browser or server
    if (typeof window !== 'undefined') {
      const params = new URL(document.location).searchParams;
      return params.get('ob') || 'id';
    } else {
      return undefined;
    }
  });

  const [sortOrder, setSortOrder] = React.useState(() => {
    // Check if this is browser or server
    if (typeof window !== 'undefined') {
      const params = new URL(document.location).searchParams;
      return params.get('od') || 'asc';
    } else {
      return undefined;
    }
  });

  const onChangeSort = async (e) => {
    const currentUrl = window.location.href;
    e.preventDefault();
    const url = new URL(currentUrl, window.location.origin);
    if (e.target.value === '') {
      url.searchParams.delete('ob');
    } else {
      url.searchParams.set('ob', e.target.value);
    }
    url.searchParams.append('ajax', true);
    setSortBy(e.target.value);
    await AppContextDispatch.fetchPageData(url);
    url.searchParams.delete('ajax');
    history.pushState(null, '', url);
  };

  const onChangeDirection = async (e) => {
    const currentUrl = window.location.href;
    e.preventDefault();
    const url = new URL(currentUrl, window.location.origin);
    const order = sortOrder.toLowerCase() === 'asc' ? 'desc' : 'asc';
    url.searchParams.set('od', order);
    url.searchParams.append('ajax', true);
    setSortOrder(order);
    await AppContextDispatch.fetchPageData(url);
    url.searchParams.delete('ajax');
    history.pushState(null, '', url);
  };

  return (
    <div className="product-sorting mb-1">
      <div className="product-sorting-inner flex justify-end items-center space-x-05">
        {/* <div>
          <span span className='font-16'>{_('Sort By')}:</span>
        </div> */}
        <div div style={{ width: '130px' }
        }>
          <Select
            className="form-control font-16"
            onChange={async (e) => {
              await onChangeSort(e);
            }}
            value={sortBy}
            options={options.map((o) => ({ value: o.code, text: o.name }))}
            disableDefaultOption={false}
            placeholder={_('Sort by')}
          />
        </div >
        <div className="sort-direction self-center">
          <a onClick={(e) => onChangeDirection(e)} href="#">
            {sortOrder === 'desc' ? (
              <IoArrowUpOutline className='text-dark' />
            ) : (
              <IoArrowDownOutline className='text-dark' />

            )}
          </a>
        </div>
      </div >
    </div >
  );
}
