{{ config(materialized='table', tags=["votes_pipeline"]) }}

select
    id,
    creation_date,
    post_id,
    vote_type_id
from {{ source('stackoverflow', 'votes') }}
