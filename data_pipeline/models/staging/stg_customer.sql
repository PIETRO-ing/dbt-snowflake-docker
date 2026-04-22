{{
  config(
    schema = 'megamart_schema'
    )
}}

select 
    *
from 
    {{ source('source', 'dim_customer') }}