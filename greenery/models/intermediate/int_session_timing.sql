select
    session_id,
    min(event_created_at_utc) as session_started_at,
    max(event_created_at_utc) as session_ended_at
from {{ ref('stg_postgres__events') }}
group by 1