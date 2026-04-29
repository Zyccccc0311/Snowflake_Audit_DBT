{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'ACCOUNTS') }}