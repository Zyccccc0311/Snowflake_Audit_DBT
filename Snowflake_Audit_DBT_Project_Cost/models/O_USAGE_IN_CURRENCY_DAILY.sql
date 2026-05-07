{{ config(materialized='table') }}
WITH usage_in_currency AS(
SELECT
    ORGANIZATION_NAME, 
    CONTRACT_NUMBER, 
    ACCOUNT_NAME, 
    ACCOUNT_LOCATOR, 
    REGION, 
    SERVICE_LEVEL, 
    USAGE_DATE, 
    USAGE_TYPE, 
    CAST(USAGE AS DECIMAL(15,6)) as "USAGE", 
    CURRENCY, 
    CAST(USAGE_IN_CURRENCY AS DECIMAL(15,6)) as USAGE_IN_CURRENCY, 
    BALANCE_SOURCE, 
    BILLING_TYPE, 
    RATING_TYPE, 
    SERVICE_TYPE, 
    IS_ADJUSTMENT
FROM {{ source('organization_usage', 'USAGE_IN_CURRENCY_DAILY') }}
),
rate_cny_sek AS (
SELECT * 
FROM {{ source('cost', 'D_RATE') }}
)

select 
    usage_in_currency.*, 
    CAST(rate_cny_sek.RATE*usage_in_currency.USAGE_IN_CURRENCY AS DECIMAL(15,6)) AS USAGE_IN_CURRENCY_SEK
FROM usage_in_currency
LEFT JOIN rate_cny_sek
ON
rate_cny_sek.RATE_DATE=usage_in_currency.USAGE_DATE2026595

