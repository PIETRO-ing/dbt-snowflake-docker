with store as (
    select * from {{ ref('stg_store') }}
),

sales as (
    select * from {{ ref('stg_sales') }}
),

final as (
select sales.store_sk, sales.sales_id, sales.date_sk, sales.product_sk, sales.customer_sk, sales.promotion_sk, 
       sales.quantity, sales.unit_price, sales.gross_amount, sales.discount_amount, sales.net_amount, sales.payment_method,
       store.store_code, store.store_name, store.city, store.state_province, store.region, store.country, store.open_date, store.sq_ft
from sales
inner join store
on sales.store_sk = store.store_sk
)

select * from final