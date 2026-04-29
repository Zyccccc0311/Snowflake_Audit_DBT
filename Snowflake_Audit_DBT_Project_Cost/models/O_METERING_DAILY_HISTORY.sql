{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'METERING_DAILY_HISTORY') }}