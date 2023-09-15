{{
    config(
        materialized='ephemeral'
    )
}}


SELECT
    *
FROM
    {{ source('sources', 'categories') }}
