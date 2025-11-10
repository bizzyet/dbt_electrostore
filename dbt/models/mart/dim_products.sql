-- Dimension table for products

with int_products as (

    select * from {{ ref('int_products') }}

)

select * from int_products
