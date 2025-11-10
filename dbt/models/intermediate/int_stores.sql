-- Intermediate store data

with stg_stores as (

    select * from {{ ref('stg_stores') }}

)

select
    store_id,
    store_name,
    store_code,
    city,
    state,
    region,
    store_type,
    size_sqft,
    status,
    open_date

from stg_stores
