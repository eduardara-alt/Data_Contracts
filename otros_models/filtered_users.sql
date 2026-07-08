{{
    config(
        materialized='view',
        meta={
            'columns': [
                {'name': 'about_me', 'description': 'Descripción del usuario'},
                {'name': 'creation_date', 'description': 'Fecha de creación de la cuenta'},
                {'name': 'location', 'description': 'Ubicación del usuario'},
                {'name': 'up_votes', 'description': 'Número de votos positivos'},
                {'name': 'views', 'description': 'Número de vistas del perfil'},
                {'name': 'website_url', 'description': 'URL del sitio web del usuario'},
                {'name': 'id', 'description': 'ID del usuario'},
                {'name': 'display_name', 'description': 'Nombre visible del usuario'},
                {'name': 'age', 'description': 'Edad del usuario'},
                {'name': 'last_access_date', 'description': 'Última fecha de acceso'},
                {'name': 'reputation', 'description': 'Reputación del usuario'},
                {'name': 'down_votes', 'description': 'Número de votos negativos'},
                {'name': 'profile_image_url', 'description': 'URL de la imagen de perfil'}
            ]
        }
    )
}}

select
    about_me,
    creation_date,
    location,
    up_votes,
    views,
    website_url,
    id,
    display_name,
    age,
    last_access_date,
    reputation,
    down_votes,
    profile_image_url
from {{ ref('stg_users') }}


where (
    id in (select owner_user_id from {{ ref('filtered_questions') }})
    or id in (select owner_user_id from {{ ref('filtered_answers') }})
)
and creation_date > '2021-01-01'

{% if is_incremental() %}
  and creation_date > (select max(creation_date) from {{ this }})
{% endif %}