{{
  config(
    materialized='view'
  )
}}

select 
    product_id,
    count (distinct case when page_views > 0 then session_id end) as page_views,
    count (distinct case when add_to_carts > 0 then session_id end) as add_to_carts,
    count (distinct case when checkouts > 0 then session_id end) as checkouts
from {{ref ('fact_page_views')}}
group by 1