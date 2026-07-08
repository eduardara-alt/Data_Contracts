{% macro emit_alias_name(model) %}
  {% if model.config.alias is defined %}
    {{ log("Alias: " ~ model.config.alias, info=True) }}
  {% else %}
    {{ log("No alias definido para " ~ model.name, info=True) }}
  {% endif %}
{% endmacro %}