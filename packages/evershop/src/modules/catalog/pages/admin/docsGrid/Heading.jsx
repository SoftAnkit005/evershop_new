import React from 'react';
import PageHeading from '@components/admin/cms/PageHeading';

export default function Heading() {
  return (
    <div className='' style={{ margin: '0 auto' }}>
      <PageHeading backUrl={null} heading="Documents" />
    </div>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
