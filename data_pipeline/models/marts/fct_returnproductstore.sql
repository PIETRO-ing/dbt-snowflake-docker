select 
    product_name,
    store_name,
    return_reason,
    sum(returned_qty) as returns_qty,
    sum(refund_amount) as refund_amount_$
from 
    {{ ref('int_returnproductstore') }}
group by 1,2,3
order by refund_amount_$ desc
