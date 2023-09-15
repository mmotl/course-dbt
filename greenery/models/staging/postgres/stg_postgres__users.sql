{{
  config(
    materialized='table'
  )
}}

select
    user_id
    ,first_name
    ,last_name
    ,email
    ,phone_number
    ,created_at as created_at_utc
    ,updated_at
    ,address_id

from {{source('postgres', 'users')}}