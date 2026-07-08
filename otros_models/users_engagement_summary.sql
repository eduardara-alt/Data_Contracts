{{ config(tags=["users_pipeline"]) }}

SELECT
    u.id,
    u.display_name,
    u.reputation,
    s.total_upvotes / NULLIF(s.total_votes, 0) AS upvote_ratio,
    SAFE_DIVIDE(s.total_votes, s.total_posts) AS avg_votes_per_post,
    (u.reputation * 0.3 + s.total_votes * 0.7) AS engagement_score,
    CASE 
        WHEN s.total_posts > 100 AND s.total_upvotes > 500 THEN 'power_user'
        WHEN s.total_posts > 20 THEN 'active_user'
        ELSE 'casual_user'
    END AS user_segment
FROM {{ ref('users_transformed2') }} u
LEFT JOIN (
    SELECT
        id AS user_id,
        (questions_posted_upvotes + questions_posted_downvotes +
         answers_posted_upvotes + answers_posted_downvotes) AS total_votes,
        (questions_posted_upvotes + answers_posted_upvotes) AS total_upvotes,
        (questions_posted + answers_posted) AS total_posts
    FROM {{ ref('user_stats') }}
) s
ON u.id = s.user_id