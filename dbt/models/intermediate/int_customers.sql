-- Intermediate customer data

with stg_customers as (

    select * from {{ ref('stg_customers') }}

)

select
    concat(customer_id, '_', customer_name) as customer,
    customer_id,
    customer_name,
    concat('e-post:', customer_id, '@electrostore.com') as email_text,
    email,
    phone,
    customer_type,
    region,
    status,
    registration_date,
    last_purchase_date

from stg_customers
