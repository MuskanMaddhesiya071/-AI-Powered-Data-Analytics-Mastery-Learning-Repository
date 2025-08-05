-- SQL Questions
create database SQL_Questions;

select * from [dbo].[Indian_Kids_Screen_Time];

-- 1) What is the average daily screen time for kids, grouped by age and gender?
select age, gender,avg(avg_daily_screen_time_hr) as avg_daily_screen_time_hr
from [dbo].[Indian_Kids_Screen_Time]
group by age, gender
order by avg_daily_screen_time_hr

-- 2) Which device is most commonly used as the primary device among kids?
select primary_device, count(*) as usage_count
from [dbo].[Indian_Kids_Screen_Time]
group by primary_device
order by usage_count desc;

-- 3) What percentage of kids exceed the recommended screen time limit, and how does this vary by urban or rural location?4
with totalKids as(
          select urban_or_rural,count(*) as total
          from [dbo].[Indian_Kids_Screen_Time]
          group by urban_or_rural),
exceeded as(
              select urban_or_rural, count(*) as exceeded
              from [dbo].[Indian_Kids_Screen_Time]
              where Exceeded_Recommended_Limit='True'
              group by urban_or_rural)
                      
select t.Urban_or_Rural, e.exceeded, t.total,cast(e.exceeded as float)/t.total*100 as percentage_exceeded
from totalKids t
join exceeded e on t.urban_or_rural=e.urban_or_rural


-- 4) What are the most frequently reported health impacts associated with high screen time?
select value as health_impacts, count(*) as impact_count
from [dbo].[Indian_Kids_Screen_Time]
cross apply string_split(Health_Impacts, ',')
where  Exceeded_Recommended_Limit='True'
and Health_Impacts is not null
and Health_Impacts <>'None'
group by value
order by impact_count desc;

-- 5) Is there a relationship between exceeding the recommended screen time limit and reporting any health impacts?
select Exceeded_recommended_limit, 
       case   
            when health_impacts is null or health_impacts='None' then 'No Health Impact'
            else 'Reported_health_Impact'
        end as health_impact_status,
        count(*) as count
from [dbo].[Indian_Kids_Screen_Time]
group by 
        Exceeded_recommended_limit,
case   
    when health_impacts is null or health_impacts='None' then 'No Health Impact'
    else 'Reported_health_Impact'
end;