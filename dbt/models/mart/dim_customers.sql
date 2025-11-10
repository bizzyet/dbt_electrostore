-- Dimension table for customers

with int_customers as (

    select * from {{ ref('int_customers') }}

)

select * from int_customers
