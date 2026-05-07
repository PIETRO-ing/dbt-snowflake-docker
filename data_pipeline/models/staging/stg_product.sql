select 
    *
from 
    {{ source('public', 'dim_product') }}