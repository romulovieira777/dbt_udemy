{{
    config(
        materialized='table',
        pre_hook=["
            begin; lock table {{ target.schema }}.bireport;
        "],
        post_hook=["
            COMMIT;
            GRANT USAGE ON SCHEMA {{ target.schema }} TO GROUP biusers;
            GRANT SELECT ON TABLE {{ target.schema }}.bireport TO GROUP biusers;
        "]
    )
}}


SELECT
    *
FROM
    {{ ref('joins')}}
