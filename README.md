# Analytics engineering with dbt  

### __Matthias' project__
---
### week 3 questions/answers 
- overall conversion rate:  
    - 0.624567  
    I made a report layer for this,  
    ```/marts/reports/report_conversion_rate_overall```

- conversion rate by product:  
    (by conversion rate descending)

| PRODUCT_NAME         | CONVERSION_RATE |
|----------------------|-----------------|
| String of pearls     | 0.609375        |
| Arrow Head           | 0.555556        |
| Cactus               | 0.545455        |
| ZZ Plant             | 0.539683        |
| Bamboo               | 0.537313        |
| Rubber Plant         | 0.518519        |
| Monstera             | 0.510204        |
| Calathea Makoyana    | 0.509434        |
| Fiddle Leaf Fig      | 0.5             |
| Majesty Palm         | 0.492537        |
| Aloe Vera            | 0.492308        |
| Devil's Ivy          | 0.488889        |
| Philodendron         | 0.483871        |
| Jade Plant           | 0.478261        |
| Pilea Peperomioides  | 0.474576        |
| Spider Plant         | 0.474576        |
| Dragon Tree          | 0.467742        |
| Money Tree           | 0.464286        |
| Orchid               | 0.453333        |
| Bird of Paradise     | 0.45            |
| Ficus                | 0.426471        |
| Birds Nest Fern      | 0.423077        |
| Pink Anthurium       | 0.418919        |
| Boston Fern          | 0.412698        |
| Alocasia Polly       | 0.411765        |
| Peace Lily           | 0.409091        |
| Ponytail Palm        | 0.4             |
| Snake Plant          | 0.39726         |
| Angel Wings Begonia  | 0.393443        |
| Pothos               | 0.344262        |

```sql
select 
pv.product_id
, prod.product_name
, count(distinct case when checkouts > 0 then session_id end) / count(distinct session_id) as conversion_rate 
from fact_page_views pv
left join stg_postgres__products prod
            on pv.product_id = prod.product_id
group by 1, 2
order by 3 desc; 
```
    

### week 2 questions/answers 
- no mandatory questions  

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
