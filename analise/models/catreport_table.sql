{{
    config(
        materialized='table'
    )
}}


SELECT
    *
FROM
    {{ source('sources', 'categories') }}
