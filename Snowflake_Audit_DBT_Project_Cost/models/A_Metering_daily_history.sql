DEMO_DB.PUBLIC.DBT_TEST_PROJECT{{ config(materialized='table') }}

select
    * 
from {{ source('account_usage', 'METERING_DAILY_HISTORY') }}