-- Dimension table for stores

with int_stores as (

    select * from {{ ref('int_stores') }}

)

select * from int_stores
