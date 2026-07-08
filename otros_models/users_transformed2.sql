{{ config(tags=["users_pipeline"]) }}

SELECT
    id,
    display_name,
    SAFE_CAST(age AS INT64) AS age,
    reputation,
    location,
    creation_date,
    last_access_date,
    DATE_DIFF(CURRENT_DATE(), DATE(creation_date), DAY) AS account_age_days,
    up_votes + down_votes AS total_votes,
    views,
    website_url
FROM {{ ref('users') }}