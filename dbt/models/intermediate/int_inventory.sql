-- Intermediate inventory data

with stg_inventory as (

    select * from {{ ref('stg_inventory') }}

)

select
    inventory_id,
    product_id,
    store_id,
    stock_level,
    reorder_point,
    last_updated

from stg_inventory
