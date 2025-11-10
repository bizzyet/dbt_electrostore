-- Fact table for sales transactions

with int_sales as (

    select * from {{ ref('int_sales') }}

)

select * from int_sales
