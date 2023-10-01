{{
  config(
    materialized='table'
  )
}}

select
    event_id
    ,session_id
    ,user_id
    ,event_type
    ,page_url
    ,created_at as event_created_at_utc
    ,order_id
    ,product_id

from {{source('postgres', 'events')}}