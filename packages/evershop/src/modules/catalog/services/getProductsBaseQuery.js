const { select } = require("@evershop/postgres-query-builder");

module.exports.getProductsBaseQuery = () => {
  const query = select().from("product");
  query
    .leftJoin("product_description")
    .on(
      "product_description.product_description_product_id",
      "=",
      "product.product_id"
    );
  query
    .innerJoin("product_inventory")
    .on(
      "product_inventory.product_inventory_product_id",
      "=",
      "product.product_id"
    );
  query
    .leftJoin("product_image")
    .on("product_image.product_image_product_id", "=", "product.product_id")
    .and("product_image.is_main", "=", true);

  return query;
};

module.exports.getAllProductsBaseQuery = () => {
  // const query = select({
  //   product_name: "product_description.name",
  //   category_name: "category_description.name",
  //   parent_category_name: "parent_category_description.name",
  //   product_url_key: "product_description.url_key",
  //   category_url_key: "category_description.url_key",
  //   parent_category_url_key: "parent_category_description.url_key",
  // }).from("product");
  // query
  //   .innerJoin("category")
  //   .on("category.category_id", "=", "product.category_id");
  // query
  //   .innerJoin("category_description")
  //   .on(
  //     "category_description.category_description_category_id",
  //     "=",
  //     "category.category_id"
  //   );
  // query
  //   .innerJoin("product_description")
  //   .on(
  //     "product_description.product_description_product_id",
  //     "=",
  //     "product.product_id"
  //   );
  // query
  //   .leftJoin("category", "parent_category")
  //   .on("parent_category.category_id", "=", "category.parent_id");
  // query
  //   .leftJoin("category_description", "parent_category_description")
  //   .on(
  //     "parent_category_description.category_description_category_id",
  //     "=",
  //     "parent_category.category_id"
  //   );


  const query =  `SELECT 
  product_description.name AS product_name, 
  category_description.name AS category_name,
  parent_category_description.name AS parent_category_name,
  product_description.url_key AS product_url_key,
  category_description.url_key AS category_url_key,
  parent_category_description.url_key AS parent_category_url_key
    FROM 
        product
    INNER JOIN 
        category ON category.category_id = product.category_id
    INNER JOIN 
        category_description ON category_description.category_description_category_id = category.category_id
    INNER JOIN 
        product_description ON product_description.product_description_product_id = product.product_id
    LEFT JOIN 
        category AS parent_category ON parent_category.category_id = category.parent_id
    LEFT JOIN 
        category_description AS parent_category_description ON parent_category_description.category_description_category_id = parent_category.category_id;`;
  return query;
};
