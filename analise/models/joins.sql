WITH prod AS (
    SELECT
        categories.category_name
      , suppliers.company_name AS supplier
      , products.product_name
      , products.unit_price
      , products.product_id
    FROM
        {{ source('sources', 'products') }} AS products
    LEFT JOIN
        {{ source('sources', 'suppliers') }} AS suppliers
    ON
        products.supplier_id = suppliers.supplier_id
    LEFT JOIN
        {{ source('sources', 'categories') }} AS categories
    ON
        products.category_id = categories.category_id
),
order_detail AS (
    SELECT
        prod.*
      , order_detail.order_id
      , order_detail.quantity
      , order_detail.discount
    FROM
        {{ ref('orderdetails') }} AS order_detail
    LEFT JOIN
        prod AS prod
    ON
        order_detail.product_id = prod.product_id
),
ordrs AS (
    SELECT
        orders.order_date
      , orders.order_id
      , customers.company_name AS customer
      , employees.name AS employee
      , employees.age
      , employees.lengthofservice
    FROM
        {{ source('sources', 'orders') }} AS orders
    LEFT JOIN
        {{ ref('customers') }} AS customers
    ON
        orders.customer_id = customers.customer_id
    LEFT JOIN
        {{ ref('employees') }} AS employees
    ON
        orders.employee_id = employees.employee_id
    LEFT JOIN
        {{ source('sources', 'shippers') }} AS shippers
    ON
        orders.ship_via = shippers.shipper_id
),
finaljoin AS (
    SELECT
        order_detail.*
      , ordrs.order_date
      , ordrs.customer
      , ordrs.employee
      , ordrs.age
      , ordrs.lengthofservice
    FROM
        order_detail
    INNER JOIN
        ordrs
    ON
        order_detail.order_id = ordrs.order_id
)
SELECT
    *
FROM
    finaljoin
