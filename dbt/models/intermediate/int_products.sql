-- Intermediate product data

with stg_products as (

    select * from {{ ref('stg_products') }}

),

stg_account_managers as (

    select * from {{ ref('stg_product_account_managers') }}

),

joined as (

    select
        p.product_id,
        p.product_name,
        p.sku,
        p.category,
        p.subcategory,
        p.brand,
        p.unit_price,
        p.cost,
        p.status,
        p.launch_date,
        am.account_manager

    from stg_products as p
    left join stg_account_managers as am
        on p.product_id = am.product_id

)

select * from joined
