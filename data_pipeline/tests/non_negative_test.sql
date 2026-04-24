select
    *
from 
    {{ ref('stg_sales') }}
where 
    gross_amount < 0 and net_amount < 0