select 
    *
from 
    {{ source('public', 'fact_returns') }}