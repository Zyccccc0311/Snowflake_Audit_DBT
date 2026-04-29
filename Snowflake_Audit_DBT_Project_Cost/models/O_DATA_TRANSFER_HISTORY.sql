{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'DATA_TRANSFER_HISTORY') }}