{% macro add_openlineage_metadata() %}
{% set extra_meta = {
    "owner": "data-team",
    "layer": "silver",
    "domain": "etl"
} %}
{% do return(extra_meta) %}
{% endmacro %}