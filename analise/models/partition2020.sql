SELECT
    *
FROM
    {{ ref('joins')}}
WHERE
    EXTRACT(YEAR FROM order_date) = 2020
