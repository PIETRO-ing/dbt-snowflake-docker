select 
    store_name,
    round(sum(net_amount)) as total_sales
from 
    {{ ref('int_revenue') }} as stores

group by 1
order by round(sum(net_amount))

