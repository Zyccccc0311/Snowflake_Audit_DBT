{{ config(materialized='table') }}
with 
warehouse_metering as(
select
    ORGANIZATION_NAME, 
    ACCOUNT_NAME, 
    REGION, 
    SERVICE_TYPE, 
    START_TIME, 
    END_TIME,
    TO_DATE(CONVERT_TIMEZONE('UTC', START_TIME)) as START_DATE,
    TO_DATE(CONVERT_TIMEZONE('UTC', END_TIME)) as END_DATE,
    case
        when START_DATE = END_DATE then true
        else false
    end as IS_SAME_DAY,
    TO_DATE(GREATEST(START_DATE,END_DATE)) as SERVICE_DATE, 
    WAREHOUSE_ID, 
    WAREHOUSE_NAME, 
    cast(CREDITS_USED as decimal(15,6)) as CREDITS_USED, 
    cast(CREDITS_USED_COMPUTE as decimal(15,6)) as CREDITS_USED_COMPUTE, 
    cast(CREDITS_USED_CLOUD_SERVICES as decimal(15,6)) as CREDITS_USED_CLOUD_SERVICES, 
    ACCOUNT_LOCATOR
from {{ source('organization_usage', 'WAREHOUSE_METERING_HISTORY') }}
),
credit_rate as(
select *
from {{ source('organization_usage', 'RATE_SHEET_DAILY') }}
where USAGE_TYPE<>'adj for incl cloud services'
)

select 
warehouse_metering.*,
credit_rate.EFFECTIVE_RATE
from warehouse_metering
left join credit_rate
on 
credit_rate.ACCOUNT_NAME=warehouse_metering.ACCOUNT_NAME
and
credit_rate.SERVICE_TYPE=warehouse_metering.SERVICE_TYPE
and
credit_rate.DATE=warehouse_metering.SERVICE_DATE