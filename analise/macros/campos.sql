{% macro retorna_campos() %}
{{ return('
    category_name, 
    supplier,
    product_name,
    product_id
') 
}}
{% endmacro %}