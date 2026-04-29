{{ config(materialized='table') }}

select
    * 
from {{ source('organization_usage', 'AUTOMATIC_CLUSTERING_HISTORY') }}