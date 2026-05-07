select 
    *
from 
    {{ source('public', 'dim_customer') }}