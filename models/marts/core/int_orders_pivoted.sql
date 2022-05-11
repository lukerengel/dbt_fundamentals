{%- set payment_methods=['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

with payments as (
    select * from {{ ref('stg_payments') }}
),

final as (
    select 
        order_id,
        {% for pm in payment_methods -%}
            {% if loop.last%}
            sum(case when payment_method = '{{ pm }}' then amount else 0 end) as {{ pm }}_amount
            {% else %}
            sum(case when payment_method = '{{ pm }}' then amount else 0 end) as {{ pm }}_amount,
            {% endif %}
        {%- endfor %}
    from payments
    where status = 'success'
    group by 1
)

select * from final