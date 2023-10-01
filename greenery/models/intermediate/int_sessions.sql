{{
  config(
    materialized='table'
  )
}}

with
events as (
    select * from {{ ref('stg_postgres__events')}}
),

order_items as (
    select * from {{ ref('stg_postgres__order_items')}}
),

final as (
    select
      e.session_id
      , e.user_id
      , coalesce(e.product_id,oi.product_id) as product_id
      , sum (case when e.event_type = 'page_view' then 1 else 0 end) as page_views
      , sum (case when e.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts
      , sum (case when e.event_type = 'checkout' then 1 else 0 end) as checkouts
      , sum (case when e.event_type = 'package_shipped' then 1 else 0 end) as packages_shipped
    from events e
      left join order_items oi
      on e.order_id = oi.order_id
    group by 1,2,3
)

select * from final