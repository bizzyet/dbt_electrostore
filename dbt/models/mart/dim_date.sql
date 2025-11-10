-- Date dimension table

with int_date as (

    select * from {{ ref('int_date') }}

)

select * from int_date
