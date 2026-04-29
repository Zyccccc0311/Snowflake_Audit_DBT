{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'DATABASE_STORAGE_USAGE_HISTORY') }}