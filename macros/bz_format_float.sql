{% macro bz_format_float(column_name) %}
    {# Format brazilian float, removing thousands separator and replacing comma with dot#}
        try_to_double(regexp_replace(regexp_replace(regexp_replace({{ column_name }}, '\\.', ''), ',', '.'),'[^0-9\\.]',''))
{% endmacro %}