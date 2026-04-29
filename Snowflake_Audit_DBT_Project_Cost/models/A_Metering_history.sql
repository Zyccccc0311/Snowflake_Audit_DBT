{{ config(materialized='table') }}

select
    to_date(start_time) as START_DATE,
    to_date(end_time) as END_DATE,
    *
from {{ source('account_usage', 'METERING_HISTORY') }}

