select 
    *
from 
    {{ source('public', 'fact_sales') }}