{{ config(tags=["users_pipeline"]) }}

WITH base AS (
    SELECT
        id,
        display_name,
        age,
        reputation,
        account_age_days,
        total_votes,
        total_votes / NULLIF(account_age_days, 0) AS votes_per_day
    FROM {{ ref('users_transformed2') }}
),
stats AS (
    SELECT
        id AS user_id,
        (questions_posted + answers_posted) AS total_posts,
        (questions_posted_upvotes + questions_posted_downvotes +
         answers_posted_upvotes + answers_posted_downvotes) AS total_votes_received
    FROM {{ ref('user_stats') }}
)
SELECT
    b.id,
    b.display_name,
    b.age,
    b.reputation,
    b.account_age_days,
    b.votes_per_day,
    s.total_posts,
    s.total_votes_received,
    CASE 
        WHEN s.total_posts > 50 THEN 'High' 
        ELSE 'Low' 
    END AS engagement_level
FROM base b
LEFT JOIN stats s ON b.id = s.user_id