 {{
  config(
    materialized='table',
    unique_key = 'event_id'
  )
}}

-- with source as (
--     select 
--             events.event_id as event_id
--             , events.created_at as created_at
--             , events.session_id as session_id
--             , events.product_id as product_id
--             , products.name as name
--             , products.price as price
--     from {{ref('stg_postgres__events')}} events
--     left join {{ref('stg_postgres__products')}} products
--             on events.product_id = products.product_id
-- )

with source as (
    select *
    from {{ref('int_events_products')}} events
)

,
    renamed_recast as (
    select 
        event_id
        , created_at as created_at_utc
        , session_id
    -- , user_id
    -- , event_type
    -- , page_url
    -- , order_id
        , product_id
        , name as product_name
        , price as product_price
    from source
)

select * from renamed_recast