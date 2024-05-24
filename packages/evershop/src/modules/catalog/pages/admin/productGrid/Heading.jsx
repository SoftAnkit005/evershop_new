import React from 'react';
import PageHeading from '@components/admin/cms/PageHeading';
import "../../../../Styles/Index.scss"

export default function Heading() {
  return <PageHeading backUrl={null} heading="Products" />;
}

export const layout = {
  areaId: 'content',
  sortOrder: 10
};
