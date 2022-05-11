{%- set statuses=['returned', 'completed', 'return_pending', 'shipped', 'placed'] -%}

with orders as (
    select
        *
    from {{ ref('stg_orders') }}
),

order_status as (
    select 
        status,
        {% for s in statuses -%}
            {% if loop.last %}
            sum(case when status = '{{ s }}' then order_id else 0 end) as {{ s }}_sum
            {% else %}
            sum(case when status = '{{ s }}' then order_id else 0 end) as {{ s }}_count,
            {% endif %}
        {%- endfor %}
    from orders
    group by 1
)

select * from order_status