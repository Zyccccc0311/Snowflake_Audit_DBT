{{ config(materialized='table') }}

select
    * 
from {{ source('account_usage', 'WAREHOUSE_METERING_HISTORY') }}
