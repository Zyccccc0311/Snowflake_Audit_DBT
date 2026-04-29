{{ config(materialized='table') }}

with base as (

    select
        ORGANIZATION_NAME,
        CONTRACT_NUMBER,
        ACCOUNT_NAME,
        ACCOUNT_LOCATOR,
        "REGION",
        SERVICE_LEVEL,
        USAGE_DATE,
        USAGE_TYPE,
        "USAGE",
        CURRENCY,
        USAGE_IN_CURRENCY,
        BALANCE_SOURCE,
        BILLING_TYPE,
        RATING_TYPE,
        SERVICE_TYPE,
        IS_ADJUSTMENT
    from {{ source('organization_usage', 'USAGE_IN_CURRENCY_DAILY') }}

),

cloud_final as (

    select
        any_value(ORGANIZATION_NAME) as ORGANIZATION_NAME,
        any_value(CONTRACT_NUMBER) as CONTRACT_NUMBER,
        ACCOUNT_NAME,
        ACCOUNT_LOCATOR,
        any_value("REGION") as "REGION",
        any_value(SERVICE_LEVEL) as SERVICE_LEVEL,
        USAGE_DATE,
        'cloud final' as USAGE_TYPE,
        sum("USAGE") as "USAGE",
        any_value(CURRENCY) as CURRENCY,
        sum(USAGE_IN_CURRENCY) as USAGE_IN_CURRENCY,
        any_value(BALANCE_SOURCE) as BALANCE_SOURCE,
        any_value(BILLING_TYPE) as BILLING_TYPE,
        any_value(RATING_TYPE) as RATING_TYPE,
        'CLOUD_SERVICES' as SERVICE_TYPE,
        null as IS_ADJUSTMENT
    from base
    where upper(SERVICE_TYPE) = 'CLOUD_SERVICES'
    and lower(USAGE_TYPE) in ('cloud services','adj for incl cloud services')
    group by
        ACCOUNT_LOCATOR,
        ACCOUNT_NAME,
        USAGE_DATE

)

select
    *
from base

union all

select
    *
from cloud_final