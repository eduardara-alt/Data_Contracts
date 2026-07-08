{{
    config(
        materialized='view',
        meta={
            'columns': [
                {'name': 'comment_count', 'description': 'Número de comentarios'},
                {'name': 'view_count', 'description': 'Número de vistas'},
                {'name': 'post_type_id', 'description': 'Tipo de post'},
                {'name': 'accepted_answer_id', 'description': 'ID de la respuesta aceptada'},
                {'name': 'body', 'description': 'Contenido del post'},
                {'name': 'favorite_count', 'description': 'Número de favoritos'},
                {'name': 'id', 'description': 'ID del post'},
                {'name': 'last_activity_date', 'description': 'Fecha de última actividad'},
                {'name': 'owner_user_id', 'description': 'ID del usuario propietario'},
                {'name': 'last_editor_user_id', 'description': 'ID del último editor'},
                {'name': 'last_editor_display_name', 'description': 'Nombre del último editor'},
                {'name': 'title', 'description': 'Título del post'},
                {'name': 'owner_display_name', 'description': 'Nombre del propietario'},
                {'name': 'tags', 'description': 'Etiquetas del post'},
                {'name': 'answer_count', 'description': 'Número de respuestas'},
                {'name': 'community_owned_date', 'description': 'Fecha de propiedad comunitaria'},
                {'name': 'last_edit_date', 'description': 'Fecha de última edición'},
                {'name': 'parent_id', 'description': 'ID del post padre'},
                {'name': 'score', 'description': 'Puntuación del post'},
                {'name': 'creation_date', 'description': 'Fecha de creación'}
            ]
        }
    )
}}

select
    comment_count,
    view_count,
    post_type_id,
    accepted_answer_id,
    body,
    favorite_count,
    id,
    last_activity_date,
    owner_user_id,
    last_editor_user_id,
    last_editor_display_name,
    title,
    owner_display_name,
    tags,
    answer_count,
    community_owned_date,
    last_edit_date,
    parent_id,
    score,
    creation_date
from {{ ref('stg_posts_answers') }}

where parent_id in (select id from {{ ref('filtered_questions') }})
  and creation_date > '2021-01-01'

{% if is_incremental() %}
  and creation_date > (select max(creation_date) from {{ this }})
{% endif %}