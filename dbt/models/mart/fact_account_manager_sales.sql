-- Gold model: Sales pivoted by account manager in wide format
-- Shows total sales amount for each account manager across different time periods and regions

with sales_with_dimensions as (

    select
        s.sale_id,
        s.sale_date,
        s.quantity,
        s.total_amount,
        p.account_manager,
        p.category as product_category,
        st.region as store_region,
        c.customer_type,
        datefromparts(year(s.sale_date), month(s.sale_date), 1) as sale_month

    from {{ ref('int_sales') }} as s
    left join {{ ref('int_products') }} as p
        on s.product_id = p.product_id
    left join {{ ref('int_stores') }} as st
        on s.store_id = st.store_id
    left join {{ ref('int_customers') }} as c
        on s.customer_id = c.customer_id

),

aggregated as (

    select
        sale_month,
        store_region,
        product_category,
        customer_type,
        account_manager,
        sum(total_amount) as total_sales,
        sum(quantity) as total_quantity,
        count(distinct sale_id) as transaction_count

    from sales_with_dimensions
    group by
        sale_month,
        store_region,
        product_category,
        customer_type,
        account_manager

),

pivoted as (

    select
        sale_month,
        store_region,
        product_category,
        customer_type,
        {{ dbt_utils.pivot(
            column='account_manager',
            values=dbt_utils.get_column_values(
                table=ref('int_product_account_managers'),
                column='account_manager'
            ),
            agg='sum',
            then_value='total_sales',
            else_value=0,
            prefix='sales_',
            suffix=''
        ) }}

    from aggregated
    group by
        sale_month,
        store_region,
        product_category,
        customer_type

)

select * from pivoted
