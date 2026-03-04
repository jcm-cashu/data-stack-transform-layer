{% macro week_of_month(col) -%}
    {#
        This macro returns the week of the month for a given date.
    #}
    {{ 1 + floor((day(col)-1)/7) }}
{%- endmacro %}
