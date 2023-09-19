SELECT
    shippers.company_name
  , emails.shipper_email
FROM
    {{ source('sources', 'shippers') }} AS shippers
LEFT JOIN
    {{ ref('shippers_emails') }} AS emails
ON
    (shippers.shipper_id = emails.shipper_id)
