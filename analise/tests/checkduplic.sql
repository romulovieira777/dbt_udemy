SELECT
    COUNT(*) AS count
  , company_name
  , contact_name
FROM
    {{ ref('customers') }}
GROUP BY
    company_name
  , contact_name
HAVING
    COUNT(*) > 1
