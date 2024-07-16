import PropTypes from 'prop-types';
import React from 'react';
import ProductIcon from '@heroicons/react/solid/esm/ArchiveIcon';
import { BiSolidCategory,BiSolidCollection } from "react-icons/bi";
import { MdEditAttributes, MdRateReview } from "react-icons/md";
import { IoMdPricetags } from "react-icons/io";
import NavigationItemGroup from '@components/admin/cms/NavigationItemGroup';
import { IoDocuments } from 'react-icons/io5';

export default function CatalogMenuGroup({
  productGrid,
  categoryGrid,
  attributeGrid,
  collectionGrid,
  tagGrid,
  reviewGrid,
}) {
  return (
    <NavigationItemGroup
      id="catalogMenuGroup"
      name="Catalog"
      items={[
        {
          Icon: ProductIcon,
          url: productGrid,
          title: 'Products'
        },
        {
          Icon: BiSolidCategory,
          url: categoryGrid,
          title: 'Categories'
        },
        {
          Icon: BiSolidCollection ,
          url: collectionGrid,
          title: 'Collections'
        },
        {
          Icon: MdEditAttributes,
          url: attributeGrid,
          title: 'Attributes'
        },
        {
          Icon: IoMdPricetags,
          url: tagGrid,
          title: 'Tags'
        },
        {
          Icon: MdRateReview,
          url: reviewGrid,
          title: 'Reviews'
        },
      ]}
    />
  );
}

CatalogMenuGroup.propTypes = {
  attributeGrid: PropTypes.string.isRequired,
  categoryGrid: PropTypes.string.isRequired,
  collectionGrid: PropTypes.string.isRequired,
  productGrid: PropTypes.string.isRequired,
  tagGrid: PropTypes.string.isRequired,
  reviewGrid: PropTypes.string.isRequired,
};

export const layout = {
  areaId: 'adminMenu',
  sortOrder: 20
};

export const query = `
  query Query {
    productGrid: url(routeId: "productGrid")
    categoryGrid: url(routeId: "categoryGrid")
    attributeGrid: url(routeId: "attributeGrid")
    collectionGrid: url(routeId: "collectionGrid")
    tagGrid: url(routeId: "tagGrid")
    reviewGrid: url(routeId: "reviewGrid")
  }
`;
