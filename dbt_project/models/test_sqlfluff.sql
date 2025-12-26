SELECT id,name,email FROM {{ ref('orders') }} WHERE status='active'
