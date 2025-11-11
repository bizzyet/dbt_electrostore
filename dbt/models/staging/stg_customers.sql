-- Staging model for customers
-- Purpose: Clean and standardize raw customer data from DLT pipeline

with source as (

    select * from {{ source('archive_electrostore', 'customers') }}

),

renamed as (

    select
        -- Primary key
        cast(customer_id as int) as customer_id,

        -- Customer attributes
        -- customer_name removed for GDPR compliance
        cast(email as nvarchar(255)) as email,
        cast(phone as nvarchar(50)) as phone,
        cast(customer_type as nvarchar(50)) as customer_type,
        cast(region as nvarchar(50)) as region,
        cast(status as nvarchar(50)) as status,
        cast(registration_date as date) as registration_date,
        cast(last_purchase_date as date) as last_purchase_date,

        -- DLT metadata
        cast(_dlt_load_id as nvarchar(255)) as _dlt_load_id,
        cast(_dlt_id as nvarchar(255)) as _dlt_id

    from source

)

select * from renamed

-- Example: Add data quality filters
-- where email is not null
--   and customer_id is not null
