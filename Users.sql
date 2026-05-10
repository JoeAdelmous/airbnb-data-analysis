SELECT TOP (1000) [name]
      ,[host_id]
      ,[host_identity_verified]
      ,[host_name]
      ,[neighborhood_group]
      ,[neighborhood]
      ,[lat]
      ,[long]
      ,[instant_bookable]
      ,[cancellation_policy]
      ,[room_type]
      ,[construction_year]
      ,[price]
      ,[service_fee]
      ,[minimum_nights]
      ,[number_of_reviews]
      ,[last_review]
      ,[minimum_total_price]
  FROM [Airbnb].[dbo].[Airbnb]
 
 with cte as (
 select distinct HOST_NAME,[neighborhood] , CONCAT(HOST_NAME,' (',[neighborhood],')') name_neighborhood
 from Airbnb)
 ,final as (
 select [host_id]
      ,[host_identity_verified]
      ,c.name_neighborhood
      ,[neighborhood_group]
      ,a.[neighborhood]
      ,[lat]
      ,[long]
      ,[instant_bookable]
      ,[cancellation_policy]
      ,[room_type]
      ,[construction_year]
      ,[price]
      ,[service_fee]
      ,[minimum_nights]
      ,[number_of_reviews]
      ,[last_review]
      ,[minimum_total_price]
  from Airbnb as a join cte as c
    on c.HOST_NAME = a.host_name
        and c.neighborhood = a.neighborhood
), maxy as (
select  name_neighborhood,sum() as maxy
from final 
group by name_neighborhood 
)
select  count(*)
from maxy  
where name_neighborhood ='Sonder (NYC) (Financial District)'
-- sales 

-- Ahmed (7)	7359

-- Anna Laura (Harlem)	60

-- reviews 
-- Sonder (NYC) (Financial District)	1024
-- Abigail (Bushwick)	1
-- -- 2770

-- -- service 
-- Christopher (Greenwich Village)	240
-- -- 105

-- Benoit (Chelsea)	10
-- -- 50




 with cte as (
 select distinct HOST_NAME,[neighborhood] , CONCAT(HOST_NAME,' (',[neighborhood],')') name_neighborhood
 from Airbnb)

 ,final as (
 select [host_id]
      ,[host_identity_verified]
      ,c.name_neighborhood
      ,[neighborhood_group]
      ,a.[neighborhood]
      ,[lat]
      ,[long]
      ,[instant_bookable]
      ,[cancellation_policy]
      ,[room_type]
      ,[construction_year]
      ,[price]
      ,[service_fee]
      ,[minimum_nights]
      ,[number_of_reviews]
      ,[last_review]
      ,[minimum_total_price]
  from Airbnb as a join cte as c
    on c.HOST_NAME = a.host_name
        and c.neighborhood = a.neighborhood)
,total_users as (
select  *,count(*) over(partition by name_neighborhood) as total
from final  )

select max(total)
from total_users


-- Sonder (NYC) (Financial District)
-- 296

