-- Intermediate sales data

with stg_sales as (

    select * from {{ ref('stg_sales') }}

)

select
    sale_id,
    customer_id,
    product_id,
    store_id,
    sale_date,
    quantity,
    unit_price,
    discount_percent,
    total_amount

from stg_sales
