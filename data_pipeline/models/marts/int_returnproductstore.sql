with returns as (
    select * from {{ ref('stg_returns') }}
)
,
products as (
    select * from {{ ref('stg_product') }}
)
,
stores as (
    select * from {{ ref('stg_store') }}
)
,
final as (
    select * from returns
    inner join products
    using (product_sk)
    inner join stores 
    using (store_sk)
)
select * from final