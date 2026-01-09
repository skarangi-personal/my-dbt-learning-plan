{% set traffic_source_values = ['Adwords', 'Email', 'Facebook', 'Organic', 'YouTube'] %}
{% set browser_values = ['Chrome', 'Firefox', 'Safari', 'IE', 'Other'] %}

SELECT
    user_id,
    COUNT(DISTINCT session_id) AS num_web_sessions,
        
    -- Fill in lines 9 - 11 for looping through traffic source pivot
    {%- for traffic_source in traffic_source_values %}
    COUNT(DISTINCT CASE WHEN traffic_source = '{{ traffic_source }}' THEN user_id END) AS num_traffic_source_{{ traffic_source }},
    {%- endfor %}
      
    -- Fill in lines 14 - 19 for looping through browser pivot
    {%- for browser_value in browser_values %}
    COUNT(DISTINCT CASE WHEN browser = '{{ browser_value }}' THEN user_id END) AS num_browser_{{ browser_value }}
    {%- if not loop.last -%}
        ,
    {%- endif -%}
    {%- endfor %}

FROM {{ ref('stg_looker__events') }}
GROUP BY 1
