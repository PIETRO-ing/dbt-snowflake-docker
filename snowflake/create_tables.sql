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


