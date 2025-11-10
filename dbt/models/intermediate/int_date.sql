-- Intermediate date dimension with calculated attributes

with date_spine as (

    select * from {{ ref('stg_date') }}

),

date_attributes as (

    select
        date_day,

        -- Year attributes
        year(date_day) as year,

        -- Quarter attributes
        datepart(quarter, date_day) as quarter,

        -- Month attributes
        month(date_day) as month_number,
        datename(month, date_day) as month_name,

        -- Week attributes
        datepart(week, date_day) as week_of_year,

        -- Day attributes
        day(date_day) as day_of_month,
        datepart(weekday, date_day) as day_of_week,
        datename(weekday, date_day) as day_name,

        -- Flags
        case
            when datepart(weekday, date_day) in (1, 7) then 1
            else 0
        end as is_weekend

    from date_spine

)

select * from date_attributes
