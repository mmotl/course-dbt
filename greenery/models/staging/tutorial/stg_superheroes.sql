{{
    config(
        materialized='table')
}}

select
id as superhero_id
,name
,gender
,eye_color
,race
,hair_color
,height
,publisher
,skin_color
,alignment
,nullif(weight, -99) as weight
,{{lbs_to_kgs('weight')}} as weight_kg

from {{source('tutorial', 'superheroes')}}