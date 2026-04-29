{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'WAREHOUSE_METERING_HISTORY') }}
