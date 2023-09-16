# Analytics engineering with dbt  

### __Matthias' project__
---

### week 1 questions/answers
- How many users do we have?  
__130 distinct users__
``` sql
-- w1 #1
select count(distinct(user_id))
from stg_postgres__users;
--130
```
- On average, how many orders do we receive per hour?  
__7.520833 orders/hour__
``` sql
-- w1 #2
with count_of_orders as(
select --created_at
       date_trunc('hour', created_at)
       ,count(*) as cnt
from stg_postgres__orders
group by 1)
select avg(cnt)
from count_of_orders;
--7.520833
```
- On average, how long does an order take from being placed to being delivered?  
__3.9 days__
``` sql
-- w1 #3
select
    avg(DATEDIFF('days', created_at, delivered_at))
from stg_postgres__orders
where delivered_at is not null and created_at is not null;
-- 3.891803
```
- How many users have only made one purchase? Two purchases? Three+ purchases?  
(Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.)  
__-1: 25__  
__-2: 28__  
__-3+: 71__  
``` sql
-- w1 #4
select count(*) as cnt
from stg_postgres__orders o
    left join stg_postgres__users u
    on o.user_id = u.user_id
group by u.user_id
having cnt=1; -- lazily changed for the desired output
--1: 25
--2: 28
--3+: 71
```
- On average, how many unique sessions do we have per hour?  
__16.327586 unique sessions/hour__
``` sql
-- w1 #5
with dist_hourly_sessions as
(select  
date_trunc('hour', created_at) as hour_created
,count(distinct(session_id)) as cnt
from stg_postgres__events
group by hour_created)
select avg(cnt)
from (dist_hourly_sessions);
--avg sessions/hour 16.327586
```

## License
GPL-3.0
