select 
    sales_info.category,
    sales_info.gender,
    round(sum(sales_info.gross_amount)) as total_sales
from 
    {{ ref('stg_sales') }} as sales
join 
    {{ ref('int_salesinfo') }} sales_info
        on sales.sales_id = sales_info.sales_id
group by 
    1,2
order by 
    round(sum(sales_info.gross_amount)) desc