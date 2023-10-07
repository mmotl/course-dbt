 {{
  config(
    materialized='view'
  )
}}

select 
        events.event_id as event_id
        , events.event_created_at_utc as created_at
        , events.session_id as session_id
        , events.product_id as product_id
        , products.product_name as name
        , products.product_price as price
from {{ref('stg_postgres__events')}} events
left join {{ref('stg_postgres__products')}} products
        on events.product_id = products.product_id