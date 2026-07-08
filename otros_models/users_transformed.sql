{{ config(tags=["users_pipeline"]) }}

SELECT
    id,
    display_name,
    reputation,
    age,
    location,
    account_age_days,
    CASE
        WHEN reputation > 1000 THEN 'high'
        WHEN reputation > 100 THEN 'medium'
        ELSE 'low'
    END AS reputation_level,
    total_votes,
    views,
    total_votes / NULLIF(account_age_days, 0) AS votes_per_day
FROM {{ ref('users_transformed') }}