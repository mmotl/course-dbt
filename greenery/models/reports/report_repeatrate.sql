{{
  config(
    materialized='view'
  )
}}

with orders_cohort as (
select user_id
,count (distinct order_id) as user_oders
from {{ref('stg_postgres__orders')}}
group by user_id
)
, users_bucket as (
select user_oders
, (user_oders = 1)::int as one_purchases
, (user_oders = 2)::int as two_purchases
, (user_oders = 3)::int as three_purchases
, (user_oders >= 2)::int as two_plus_purchases
from orders_cohort
)
select 
 --sum(one_purchases) as one_purchase
--,sum(two_purchases) as two_purchase
--,sum(two_plus_purchases) as two_plus
--,count (user_oders) users_w_purchases
sum(two_plus_purchases) / count (user_oders) as repeat_rate
from users_bucket