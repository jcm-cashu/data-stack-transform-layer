{% macro generate_schema_name(custom_schema_name, node) -%}
    {#
        This macro overrides dbt's default schema naming behavior.
        Instead of: {target_schema}_{custom_schema}
        We get just: {custom_schema} (or target_schema if no custom schema)
    #}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
