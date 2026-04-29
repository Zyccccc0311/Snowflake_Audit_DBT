{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'RATE_SHEET_DAILY') }}