with numbers as (
    select top (2921)
        row_number() over (order by (select null)) - 1 as n
    from sys.all_columns a
    cross join sys.all_columns b
)

select
    dateadd(day, n, cast('2020-01-01' as date)) as date_day
from numbers
