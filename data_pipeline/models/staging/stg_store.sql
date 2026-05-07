select 
    *
from 
    {{ source('public', 'dim_store') }}