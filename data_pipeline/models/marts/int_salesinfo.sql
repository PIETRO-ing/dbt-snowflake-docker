with sales as (
    select
        sales_id,
        product_sk,
        customer_sk,
        gross_amount,
        payment_method
    from
        {{ ref('stg_sales') }}
    ),

products as (
    select 
        product_sk,
        category
    from 
        {{ ref('stg_product') }}
),

customers as (
    select
        customer_sk,
        gender
    from
        {{ ref('stg_customer') }}
),
final as(
    select 
        sales.sales_id,
        sales.gross_amount,
        sales.payment_method,
        products.category,
        customers.gender
    from 
        sales
    inner join 
        products on products.product_sk = sales.product_sk
    inner join 
        customers on customers.customer_sk = sales.customer_sk
)

select 
    *
from 
    final
