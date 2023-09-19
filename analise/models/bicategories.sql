SELECT
    {{ retorna_campos() }}
FROM
    {{ ref('joins') }}
WHERE
    category_name = '{{var('category')}}'
