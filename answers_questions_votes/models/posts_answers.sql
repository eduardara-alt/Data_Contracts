{{
    config(
        materialized='table',
        tags=["answers_pipeline"],
        contract={"enforced": true}
    )
}}

select
    last_edit_date,
    last_editor_display_name,
    last_editor_user_id,
    owner_display_name,
    title,
    body,
    accepted_answer_id,
    owner_user_id,
    parent_id,
    post_type_id,
    id,
    score,
    answer_count,
    comment_count,
    community_owned_date,
    creation_date,
    favorite_count,
    last_activity_date,
    tags,
    view_count
from {{ source('stackoverflow', 'posts_answers') }}