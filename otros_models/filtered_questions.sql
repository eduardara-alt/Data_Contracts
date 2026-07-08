{{
    config(
        materialized='view',
        meta={
            'columns': [
                {'name': 'answer_count', 'description': 'Número de respuestas'},
                {'name': 'owner_user_id', 'description': 'ID del usuario propietario'},
                {'name': 'parent_id', 'description': 'ID del post padre'},
                {'name': 'comment_count', 'description': 'Número de comentarios'},
                {'name': 'community_owned_date', 'description': 'Fecha de propiedad comunitaria'},
                {'name': 'post_type_id', 'description': 'Tipo de post'},
                {'name': 'creation_date', 'description': 'Fecha de creación'},
                {'name': 'score', 'description': 'Puntuación del post'},
                {'name': 'tags', 'description': 'Etiquetas del post'},
                {'name': 'favorite_count', 'description': 'Número de favoritos'},
                {'name': 'last_activity_date', 'description': 'Fecha de última actividad'},
                {'name': 'last_edit_date', 'description': 'Fecha de última edición'},
                {'name': 'id', 'description': 'ID del post'},
                {'name': 'title', 'description': 'Título del post'},
                {'name': 'last_editor_display_name', 'description': 'Nombre del último editor'},
                {'name': 'last_editor_user_id', 'description': 'ID del último editor'},
                {'name': 'owner_display_name', 'description': 'Nombre del propietario'},
                {'name': 'view_count', 'description': 'Número de vistas'},
                {'name': 'body', 'description': 'Contenido del post'},
                {'name': 'accepted_answer_id', 'description': 'ID de la respuesta aceptada'}
            ]
        }
    )
}}

select
    answer_count,
    owner_user_id,
    parent_id,
    comment_count,
    community_owned_date,
    post_type_id,
    creation_date,
    score,
    tags,
    favorite_count,
    last_activity_date,
    last_edit_date,
    id,
    title,
    last_editor_display_name,
    last_editor_user_id,
    owner_display_name,
    view_count,
    body,
    accepted_answer_id
from {{ ref('stg_posts_questions') }}

where tags like '%etl%'
  and creation_date > '2021-01-01'

{% if is_incremental() %}
  and creation_date > (select max(creation_date) from {{ this }})
{% endif %}