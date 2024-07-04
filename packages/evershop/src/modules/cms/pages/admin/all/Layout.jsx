import React from 'react';
import Area from '@components/common/Area';
import './Layout.scss';
import './tailwind.scss';
import "../../../../Styles/admin.scss";

export default function AdminLayout() {
  return (
    <>
      <div className="header">
        <Area id="header" noOuter />
      </div>
      <div className="content-wrapper">
        <div className="admin-navigation">
          <Area id="adminNavigation" noOuter />
        </div>
        <div className="main-content">
          <Area id="content" className="main-content-inner" />
        </div>
      </div>
    </>
  );
}

export const layout = {
  areaId: 'body',
  sortOrder: 10
};
