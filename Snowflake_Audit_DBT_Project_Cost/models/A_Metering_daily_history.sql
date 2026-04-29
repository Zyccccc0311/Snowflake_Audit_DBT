{{ config(materialized='table') }}

select
    * 
from {{ source('account_usage', 'METERING_DAILY_HISTORY') }}