select 
    category,
    gender,
    round(sum(gross_amount)) as total_sales
from
    {{ ref('int_salesinfo') }} 
group by 
    1,2
order by round(sum(gross_amount)) desc
