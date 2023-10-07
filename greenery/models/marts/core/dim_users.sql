select
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at_utc,
    updated_at,
    address,
    zipcode,
    state,
    country
from {{ ref('stg_postgres__users') }} as u
    left join {{ ref('stg_postgres__addresses') }} as a
        on u.address_id = a.address_id