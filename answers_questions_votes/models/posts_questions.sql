{{ config(materialized='table', tags=["answers_pipeline"]) }}

select
    owner_display_name,
    tags,
    view_count,
    community_owned_date,
    creation_date,
    favorite_count,
    last_activity_date,
    owner_user_id,
    parent_id,
    post_type_id,
    score,
    title,
    body,
    accepted_answer_id,
    answer_count,
    comment_count,
    last_edit_date,
    id,
    last_editor_display_name,
    last_editor_user_id
from {{ source('stackoverflow', 'posts_questions') }}
