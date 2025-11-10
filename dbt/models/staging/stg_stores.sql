-- Staging model for stores

with source as (

    select * from {{ source('archive_electrostore', 'stores') }}

),

renamed as (

    select
        -- Primary key
        cast(store_id as int) as store_id,

        -- Store attributes
        cast(name as nvarchar(255)) as store_name,
        cast(store_code as nvarchar(50)) as store_code,
        cast(city as nvarchar(100)) as city,
        cast(state as nvarchar(50)) as state,
        cast(region as nvarchar(50)) as region,
        cast(store_type as nvarchar(50)) as store_type,
        cast(size_sqft as int) as size_sqft,
        cast(status as nvarchar(50)) as status,
        cast(open_date as date) as open_date,

        -- DLT metadata
        cast(_dlt_load_id as nvarchar(255)) as _dlt_load_id,
        cast(_dlt_id as nvarchar(255)) as _dlt_id

    from source

)

select * from renamed
