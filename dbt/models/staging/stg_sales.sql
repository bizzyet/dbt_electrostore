-- Staging model for sales transactions

with source as (

    select * from {{ source('archive_electrostore', 'sales') }}

),

renamed as (

    select
        -- Primary key
        cast(sale_id as int) as sale_id,

        -- Foreign keys
        cast(customer_id as int) as customer_id,
        cast(product_id as int) as product_id,
        cast(store_id as int) as store_id,

        -- Transaction details
        cast(sale_date as date) as sale_date,
        cast(quantity as int) as quantity,
        cast(unit_price as decimal(10,2)) as unit_price,
        cast(discount_percent as decimal(5,2)) as discount_percent,
        cast(total_amount as decimal(10,2)) as total_amount,

        -- DLT metadata
        cast(_dlt_load_id as nvarchar(255)) as _dlt_load_id,
        cast(_dlt_id as nvarchar(255)) as _dlt_id

    from source

)

select * from renamed
