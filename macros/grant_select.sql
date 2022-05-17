{% macro grant_select(schema=target.schema, role=target.user) %}

    {% set sql %}
        grant usage on schema {{ schema }} to {{ role }}
        grant select on all tables in schema {{ schema }} to {{ role }}
        grant select on all views in schema {{ schema }} to {{ role }}
    {% endset %}

    {{ log('Granting select on all tables and views in schema ' ~ target.schema ~ ' to role ' ~ role, info=True) }}
        {% do run_query(sql) %}
    {{ log('Privileges granted', info=True) }}
{% endmacro %}

{{ grant_select() }}

