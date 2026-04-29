{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'STAGE_STORAGE_USAGE_HISTORY') }}
