{{
    config(
        materialized='view',
        meta={
            'columns': [
                {'name': 'id', 'description': 'ID del usuario'},
                {'name': 'display_name', 'description': 'Nombre visible del usuario'},
                {'name': 'creation_date', 'description': 'Fecha de creación de la cuenta'},
                {'name': 'last_access_date', 'description': 'Última fecha de acceso'},
                {'name': 'profile_image_url', 'description': 'URL de la imagen de perfil'},
                {'name': 'questions_posted', 'description': 'Número de preguntas publicadas'},
                {'name': 'questions_posted_upvotes', 'description': 'Total de votos positivos en preguntas publicadas'},
                {'name': 'questions_posted_downvotes', 'description': 'Total de votos negativos en preguntas publicadas'},
                {'name': 'answers_inspired', 'description': 'Total de respuestas inspiradas en las preguntas del usuario'},
                {'name': 'answers_posted', 'description': 'Número de respuestas publicadas'},
                {'name': 'answers_posted_upvotes', 'description': 'Total de votos positivos en respuestas publicadas'},
                {'name': 'answers_posted_downvotes', 'description': 'Total de votos negativos en respuestas publicadas'}
            ]
        }
    )
}}

select
    id,
    display_name,
    creation_date,
    last_access_date,
    profile_image_url,
    (
        select count(*) from {{ ref('question_stats') }}
        where owner_user_id = filtered_users.id
    ) as questions_posted,
    (
        select sum(upvote_count) from {{ ref('question_stats') }}
        where owner_user_id = filtered_users.id
    ) as questions_posted_upvotes,
    (
        select sum(downvote_count) from {{ ref('question_stats') }}
        where owner_user_id = filtered_users.id
    ) as questions_posted_downvotes,
    (
        select sum(answer_count) from {{ ref('question_stats') }}
        where owner_user_id = filtered_users.id
    ) as answers_inspired,
    (
        select count(*) from {{ ref('answer_stats') }}
        where owner_user_id = filtered_users.id
    ) as answers_posted,
    (
        select sum(upvote_count) from {{ ref('answer_stats') }}
        where owner_user_id = filtered_users.id
    ) as answers_posted_upvotes,
    (
        select sum(downvote_count) from {{ ref('answer_stats') }}
        where owner_user_id = filtered_users.id
    ) as answers_posted_downvotes
from {{ ref('filtered_users') }}