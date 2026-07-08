{{
    config(
        materialized='view',
        meta={
            'columns': [
                {'name': 'id', 'description': 'ID de la respuesta'},
                {'name': 'owner_user_id', 'description': 'ID del usuario que respondió'},
                {'name': 'upvote_count', 'description': 'Número total de votos positivos'},
                {'name': 'downvote_count', 'description': 'Número total de votos negativos'}
            ]
        }
    )
}}

select
    id,
    owner_user_id,

    (
        select count(*)
        from {{ ref('filtered_votes') }}
        where post_id = filtered_answers.id
        and vote_type_id = 2
    ) as upvote_count,

    (
        select count(*)
        from {{ ref('filtered_votes') }}
        where post_id = filtered_answers.id
        and vote_type_id = 3
    ) as downvote_count

from {{ ref('filtered_answers') }}