{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'STORAGE_DAILY_HISTORY') }}
