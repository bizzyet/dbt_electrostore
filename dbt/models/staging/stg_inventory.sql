-- Staging model for inventory levels

with source as (

    select * from {{ source('archive_electrostore', 'inventory') }}

),

renamed as (

    select
        -- Primary key
        cast(inventory_id as int) as inventory_id,

        -- Foreign keys
        cast(product_id as int) as product_id,
        cast(store_id as int) as store_id,

        -- Inventory details
        cast(stock_level as int) as stock_level,
        cast(reorder_point as int) as reorder_point,
        cast(last_updated as date) as last_updated,

        -- DLT metadata
        cast(_dlt_load_id as nvarchar(255)) as _dlt_load_id,
        cast(_dlt_id as nvarchar(255)) as _dlt_id

    from source

)

select * from renamed
