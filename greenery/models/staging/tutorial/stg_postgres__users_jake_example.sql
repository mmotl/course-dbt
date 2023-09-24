{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{source('postgres', 'users')}}
)

, renamed_recast as (
    select
    user_id as user_guid
    , first_name
    , last_name
    , email
    , phone_number
    , created_at as created_at_utc
    , updated_at
    , address_id
  from source
)

select * from renamed_recast