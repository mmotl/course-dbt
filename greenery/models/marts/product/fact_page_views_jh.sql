with session_times as (
    select * from {{ ref('int_session_times')}}
),

sessions as (
    select * from {{ ref('int_sessions')}}
),

products as (
    select * from {{ ref('stg_postgres__products')}}
),

final as (
    select 
        se.session_id
        , se.user_id
        , se.product_id
        , p.product_name
        , p.product_price
        , se.page_views
        , se.add_to_carts
        , se.checkouts
        , se.packages_shipped
        , st.first_session_event_at_utc
        , st.last_session_event_at_utc
        , st.session_length_minutes
    from sessions se
    left join session_times st 
        on se.session_id = st.session_id
    left join products p
        on se.product_id = p.product_id
)

select * from final