{{
  config(
    materialized='table'
  )
}}

with
events as (
    select * from {{ ref('stg_postgres__events')}}
),

final as (
    select
        session_id
        , min(event_created_at_utc) as first_session_event_at_utc
        , max(event_created_at_utc) as last_session_event_at_utc
        , datediff('minute', first_session_event_at_utc, last_session_event_at_utc) as session_length_minutes
    from events
    group by 1
)

select * from final