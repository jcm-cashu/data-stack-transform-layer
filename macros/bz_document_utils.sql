{#
    Brazilian Document Utility Macros
    ---------------------------------
    Standardizes CPF (11 digits) and CNPJ (14 digits) documents.
    - Removes formatting (dots, slashes, dashes)
    - Pads with leading zeros to correct length
    - Returns VARCHAR
#}

{% macro standardize_cpf(column_name) %}
    {# Standardizes CPF to 11 characters with leading zeros #}
    lpad(
        regexp_replace({{ column_name }}::varchar, '[\.\/\-]', ''),
        11,
        '0'
    )
{% endmacro %}

{% macro standardize_cnpj(column_name) %}
    {# Standardizes CNPJ to 14 characters with leading zeros #}
    lpad(
        regexp_replace({{ column_name }}::varchar, '[\.\/\-]', ''),
        14,
        '0'
    )
{% endmacro %}

{% macro standardize_bz_gov_id(column_name, person_type_column=none) %}
    {#
        Standardizes government ID (CPF or CNPJ) based on person type or length.
        
        Args:
            column_name: The column containing the document number
            person_type_column: Optional column indicating person type ('natural'/'legal' or 'PF'/'PJ')
        
        Returns:
            - 11 chars for natural persons (CPF)
            - 14 chars for legal persons (CNPJ)
    #}
    {% if person_type_column %}
        case
            when lower({{ person_type_column }}) in ('natural', 'pf', 'natural_person', 'pessoa_fisica')
                then lpad(regexp_replace({{ column_name }}::varchar, '[\.\/\-]', ''), 11, '0')
            when lower({{ person_type_column }}) in ('legal', 'pj', 'legal_person', 'pessoa_juridica')
                then lpad(regexp_replace({{ column_name }}::varchar, '[\.\/\-]', ''), 14, '0')
            else regexp_replace({{ column_name }}::varchar, '[\.\/\-]', '')
        end
    {% else %}
        {# Infer type from length: <= 11 is CPF, > 11 is CNPJ #}
        case
            when length(regexp_replace({{ column_name }}::varchar, '[\.\/\-]', '')) <= 11
                then lpad(regexp_replace({{ column_name }}::varchar, '[\.\/\-]', ''), 11, '0')
            else lpad(regexp_replace({{ column_name }}::varchar, '[\.\/\-]', ''), 14, '0')
        end
    {% endif %}
{% endmacro %}
