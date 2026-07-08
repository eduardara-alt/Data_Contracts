-- models/staging/stg_users.sql
{{ config(materialized='table') }}
select
    id,
    display_name,
    reputation,
    about_me,
    age,
    creation_date,
    last_access_date,
    location,
    up_votes,
    down_votes,
    views,
    profile_image_url,
    website_url
from {{ source('stackoverflow', 'users') }}