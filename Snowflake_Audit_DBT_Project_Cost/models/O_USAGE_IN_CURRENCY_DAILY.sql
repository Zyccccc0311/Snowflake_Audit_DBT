{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'USAGE_IN_CURRENCY_DAILY') }}
