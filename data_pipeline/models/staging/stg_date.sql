{{config(materialized='incremental')}}

select 
    *
from 
    {{ source('source', 'dim_date') }}
{% if is_incremental() %}
  where date > coalesce((select max(date) from {{ this }}), '1900-01-01')
{% endif %}