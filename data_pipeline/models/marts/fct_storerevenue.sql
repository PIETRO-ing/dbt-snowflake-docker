select 
    stores.store_name,
    round(sum(revenue.net_amount)) as total_sales
from 
    {{ ref('stg_store') }} as stores
join 
    {{ ref('int_revenue') }} as revenue
        on  stores.store_sk = revenue.store_sk
group by 1
order by round(sum(revenue.net_amount))

