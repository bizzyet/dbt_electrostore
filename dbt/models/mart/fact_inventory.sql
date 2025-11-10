-- Fact table for inventory levels

with int_inventory as (

    select * from {{ ref('int_inventory') }}

)

select * from int_inventory
