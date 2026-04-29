{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'MONETIZED_USAGE_DAILY') }}