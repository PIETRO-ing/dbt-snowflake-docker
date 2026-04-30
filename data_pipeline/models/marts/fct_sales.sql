{% set cols = ['category', 'gender' ]%}

select 
        {% for col in cols %}
            {{col}}{% if not loop.last %}, {% endif %}
        {% endfor %},
    round(sum(gross_amount)) as total_sales
from
    {{ ref('int_salesinfo') }} 
group by 
    {% for col in cols %}
        {{ col }}{% if not loop.last %}, {% endif %}
    {% endfor %}
order by total_sales desc
