-- Staging model for product account managers

with source as (

    select * from {{ ref('product_account_managers') }}

),

renamed as (

    select
        -- Primary key
        cast(product_id as int) as product_id,

        -- Account manager
        cast(account_manager as nvarchar(100)) as account_manager

    from source

)

select * from renamed
