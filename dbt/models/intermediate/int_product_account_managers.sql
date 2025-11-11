-- Intermediate product account manager data

with stg_account_managers as (

    select * from {{ ref('stg_product_account_managers') }}

)

select
    product_id,
    account_manager

from stg_account_managers
