-- Staging model for products

with source as (

    select * from {{ source('archive_electrostore', 'products') }}

),

renamed as (

    select
        -- Primary key
        cast(product_id as int) as product_id,

        -- Product attributes
        cast(name as nvarchar(255)) as product_name,
        cast(sku as nvarchar(50)) as sku,
        cast(category as nvarchar(100)) as category,
        cast(subcategory as nvarchar(100)) as subcategory,
        cast(brand as nvarchar(100)) as brand,
        cast(unit_price as decimal(10,2)) as unit_price,
        cast(cost as decimal(10,2)) as cost,
        cast(status as nvarchar(50)) as status,
        cast(launch_date as date) as launch_date,

        -- DLT metadata
        cast(_dlt_load_id as nvarchar(255)) as _dlt_load_id,
        cast(_dlt_id as nvarchar(255)) as _dlt_id

    from source

)

select * from renamed
