SELECT
    order_details.order_id
  , order_details.product_id
  , order_details.unit_price
  , order_details.quantity
  , products.product_name
  , products.supplier_id
  , products.category_id
  , order_details.unit_price * order_details.quantity                                                       AS total
  , (products.unit_price * order_details.quantity) - (order_details.unit_price * order_details.quantity)  AS discount
FROM
    {{ source('sources', 'order_details') }}  AS order_details
LEFT JOIN
    {{ source('sources', 'products') }}       AS products
ON
    order_details.product_id = products.product_id
