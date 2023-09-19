{{
    config(
        materialized='table',
        pre_hook=["
            begin; lock table {{ target.schema }}.;
        "],
        post_hook=["
            COMMIT;
            GRANT USAGE ON SCHEMA {{ target.schema }} TO GROUP ;
            GRANT SELECT ON TABLE {{ target.schema }}. TO GROUP ;
        "]
    )
}}


SELECT
    *
FROM
    {{ ref('joins')}}
