{{
    config(
        materialized='view',
        meta={
            'columns': [
                {'name': 'date', 'description': 'Fecha de agregación diaria'},
                {'name': 'num_questions', 'description': 'Número total de preguntas ese día'},
                {'name': 'num_answers', 'description': 'Número total de respuestas ese día'},
                {'name': 'num_askers', 'description': 'Número de usuarios que hicieron preguntas ese día'},
                {'name': 'num_answerers', 'description': 'Número de usuarios que respondieron preguntas ese día'}
            ]
        }
    )
}}

with questions as (
    select
        DATE_TRUNC(DATE(creation_date), DAY) AS `date`,
        count(*) as num_questions
    from {{ ref('filtered_questions') }}
    group by `date`
),
answers as (
    select
        DATE_TRUNC(DATE(creation_date), DAY) AS `date`,
        count(*) as num_answers
    from {{ ref('filtered_answers') }}
    group by `date`
),
askers as (
    select
        DATE_TRUNC(DATE(creation_date), DAY) AS `date`,
        count(distinct(owner_user_id)) as num_askers
    from {{ ref('filtered_questions') }}
    group by `date`
),
answerers as (
    select
        DATE_TRUNC(DATE(creation_date), DAY) AS `date`,
        count(distinct(owner_user_id)) as num_answerers
    from {{ ref('filtered_answers') }}
    group by `date`
)

select
    questions.date as `date`,
    questions.num_questions,
    answers.num_answers,
    askers.num_askers,
    answerers.num_answerers
from questions
left join answers on answers.date = questions.date
left join askers on askers.date = questions.date
left join answerers on answerers.date = questions.date
order by `date` desc