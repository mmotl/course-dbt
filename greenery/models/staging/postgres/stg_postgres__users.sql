with source as (
    select * from {{source('postgres', 'users')}}
)

, renamed_recast as (
    select
    user_id as user_guid
    , first_name
    , last_name
-- , LAST_NAME
-- , EMAIL
-- , PHONE_NUMBER
, created_at as created_at_utc
-- , UPDATED_AT
-- , ADDRESS_ID
  from source
)

select * from renamed_recast