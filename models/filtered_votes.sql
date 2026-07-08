{{
    config(
        materialized='view',
        tags=["votes_pipeline"],
        meta={
            'columns': [
                {'name': 'id', 'description': 'ID del voto'},
                {'name': 'post_id', 'description': 'ID del post al que pertenece el voto'},
                {'name': 'creation_date', 'description': 'Fecha de creación del voto'},
                {'name': 'vote_type_id', 'description': 'Tipo de voto'}
            ]
        }
    )
}}

select
    id,
    post_id,
    creation_date,
    vote_type_id
from {{ ref('votes') }}

where (
    post_id in (select id from {{ ref('filtered_questions') }})
    or post_id in (select id from {{ ref('filtered_answers') }})
)
and creation_date > '2021-01-01'

{% if is_incremental() %}
  and creation_date > (select max(creation_date) from {{ this }})
{% endif %}
