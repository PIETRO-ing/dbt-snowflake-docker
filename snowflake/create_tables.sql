use role accountadmin;
use role sysadmin;

create or replace warehouse dbt_wh 
with 
warehouse_size = 'XSMALL' 
warehouse_type = 'STANDARD' 
auto_suspend = 60 --600 seconds/10 mins
auto_resume = TRUE;

use warehouse dbt_wh;

create or replace database dbt_db;

drop schema dbt_db.public;
create schema dbt_db.dbt_schema;

create or replace database dbt_raw;
create or replace stage dbt_raw.public.my_stage;

create or replace file format dbt_raw.public.csv_ff
type = CSV
skip_header = 1
trim_space = true;

list @dbt_raw.public.my_stage;

select $1, $2, $3, $4, $5, $6, $7, $8, $9
from @dbt_raw.public.my_stage/dim_customer.csv
(file_format => dbt_raw.public.csv_ff);

create or replace table dbt_raw.public.dim_customer(
customer_sk number,
customer_code varchar,
first_name varchar,
last_name varchar,
gender varchar,
email varchar,
phone varchar,
loyalty_tier varchar,
signup_date date
);

copy into dbt_raw.public.dim_customer
from @dbt_raw.public.my_stage
files = ('dim_customer.csv')
file_format = (format_name = dbt_raw.public.csv_ff);

select * from dbt_raw.public.dim_customer;

create or replace table dbt_raw.public.dim_date(
    date_sk number,
    date date,
    day number,
    month number,
    month_name varchar,
    quarter number,
    year number,
    day_of_week number,
    day_name varchar,
    is_weekend boolean,
    is_month_end boolean,
    is_month_start boolean,
    is_quarter_end boolean,
    is_quarter_start boolean
);

list @dbt_raw.public.my_stage;

copy into dbt_raw.public.dim_date
from @dbt_raw.public.my_stage
files = ('dim_date.csv')
file_format =  (format_name = dbt_raw.public.csv_ff);

create or replace table dbt_raw.public.dim_store(
    store_sk number,
    store_code varchar,
    store_name varchar,
    city varchar,
    state_province varchar,
    region varchar,
    country varchar,
    open_date date,
    sq_ft number
);

copy into dbt_raw.public.dim_store
from @dbt_raw.public.my_stage
files = ('dim_store.csv')
file_format = (format_name = dbt_raw.public.csv_ff);

create or replace table dbt_raw.public.fact_returns(
    sales_id number,
    date_sk number,
    store_sk number,
    product_sk number,
    returned_qty number,
    return_reason varchar,
    refund_amount number
);

copy into dbt_raw.public.fact_returns
from @dbt_raw.public.my_stage
files = ('fact_returns.csv')
file_format = (format_name = dbt_raw.public.csv_ff);

select * from fact_sales;

-- create dbt_role
use role accountadmin;
create role dbt_role;
show grants on warehouse dbt_wh;
grant usage on warehouse dbt_wh to role dbt_role;
grant role dbt_role to user pbln;
grant all on database dbt_db to role dbt_role;

grant all on database dbt_raw to role dbt_role;
GRANT ALL ON SCHEMA dbt_raw.public TO ROLE dbt_role;
GRANT ALL ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
      

use role dbt_role;

SHOW GRANTS ON SCHEMA dbt_raw.public;
SHOW GRANTS ON SCHEMA dbt_db.public;




