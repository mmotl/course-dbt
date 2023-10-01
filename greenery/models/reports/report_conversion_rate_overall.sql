{{
  config(
    materialized='view'
  )
}}

select count(distinct case when checkouts > 0 then session_id end) / count(distinct session_id) as conversion_rate
from {{ref('fact_page_views')}}