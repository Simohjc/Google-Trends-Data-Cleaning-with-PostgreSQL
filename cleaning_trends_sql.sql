-- remove duplicates by using CTE
with collect_tables as (
    select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'autos' as sourse_table from autos
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'beauty_fashion' as sourse_table from beauty_fashion
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'business_finance' as sourse_table from business_finance
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'climate' as sourse_table from climate
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'entertainment' as sourse_table from entertainment
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'food_drinks' as sourse_table from food_drinks
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'games' as sourse_table from games
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'health' as sourse_table from health
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'hobbies_leisure' as sourse_table from hobbies_leisure
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'jobs_education' as sourse_table from jobs_education
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'laws_government' as sourse_table from laws_government
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'others_search' as sourse_table from others_search
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'pets_animals' as sourse_table from pets_animals
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'politics' as sourse_table from politics
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'science' as sourse_table from science
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'shopping' as sourse_table from shopping
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'sports' as sourse_table from sports
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'technology' as sourse_table from technology
	union all
	select trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, 'travel_transportation' as sourse_table from travel_transportation
),
full_duplicate_table as (
    select *,
	       row_number() over( partition by trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, sourse_table) as row_num
	from collect_tables
)
select * from full_duplicate_table
where row_num > 2

--check duplicate using VIEW table 
create view collect_tables as
    select 'autos' as sourse_table , trends, search_volume, started_timestamp, ended_timestamp, trend_breakdown, explore_link from autos
	union all
	select 'beauty_fashion' as sourse_table , trends, search_volume, started_timestamp, ended_timestamp, trend_breakdown, explore_link from beauty_fashion
	union all
	select 'business_finance' as sourse_table , trends, search_volume, started_timestamp, ended_timestamp, trend_breakdown, explore_link from business_finance
	union all
	select 'climate' as sourse_table , trends, search_volume, started_timestamp,ended_timestamp, trend_breakdown, explore_link from climate
	union all
	select 'entertainment' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link  from entertainment
	union all
	select 'food_drinks' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from food_drinks
	union all
	select 'games' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from games
	union all
	select 'health' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from health
	union all
	select 'hobbies_leisure' as sourse_table, trends, search_volume, started_timestamp,ended_timestamp, trend_breakdown, explore_link from hobbies_leisure
	union all
	select 'jobs_education' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from jobs_education
	union all
	select 'laws_government' as sourse_table , trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from laws_government
	union all
	select 'others_search' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link  from others_search
	union all
	select 'pets_animals' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link  from pets_animals
	union all
	select 'politics' as sourse_table, trends, search_volume, started_timestamp,ended_timestamp, trend_breakdown, explore_link  from politics
	union all
	select 'science' as sourse_table , trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from science
	union all
	select 'shopping' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link  from shopping
	union all
	select 'sports' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from sports
	union all
	select 'technology' as sourse_table, trends, search_volume,started_timestamp, ended_timestamp, trend_breakdown, explore_link from technology
	union all
	select 'travel_transportation' as sourse_table, trends, search_volume, started_timestamp,ended_timestamp, trend_breakdown, explore_link from travel_transportation


-- run duplicate row_number to check duplicate using view tables already created
with duplicate_rows as (
    select *,
	       row_number() over( partition by trends, search_volume, started_date, ended_date, trend_breakdown, explore_link, sourse_table ) as row_num
    from collect_tables 
)

select * from duplicate_rows;




-- standardize the data (spelling..)
select * from collect_tables  ---- view table has all tables together

 -- we trim the data in the rows for cleaning for all tables 

update autos
set trends = trim(trends);
update beauty_fashion
set trends = trim(trends);
update business_finance
set trends = trim(trends);
update climate
set trends = trim(trends);
update entertainment
set trends = trim(trends);
update food_drinks
set trends = trim(trends);
update games
set trends = trim(trends);
update health
set trends = trim(trends);
update hobbies_leisure
set trends = trim(trends);
update jobs_education
set trends = trim(trends);
update laws_government
set trends = trim(trends);
update others_search
set trends = trim(trends);
update pets_animals
set trends = trim(trends);
update politics
set trends = trim(trends);
update science
set trends = trim(trends);
update shopping
set trends = trim(trends);
update sports
set trends = trim(trends);
update technology
set trends = trim(trends);
update travel_transportation
set trends = trim(trends);


select distinct search_volume, replace( replace(search_volume, 'K+', '000'), '+', '')as clean_row_num from collect_tables

select * from collect_tables

update travel_transportation
set search_volume =replace( replace(search_volume, 'K+', '000'), '+', '')
where search_volume like '%K+%' or search_volume like '%+%'


update sports
set trends = 'three m open leaderboard'
where trends like '3m%'

update entertainment
set trends = 'hours 72'
where trends like '72%'


-- date cleaning for started_date
SELECT
    started_date,
    TO_TIMESTAMP(
        REGEXP_REPLACE(
            REPLACE(
                REPLACE(started_date, ' at ', ' '),
                'UTC-4',
                ''
            ),
            '[[:space:]\u00A0\u202F]+',
            ' ',
            'g'
        ),
        'FMMonth DD, YYYY HH12:MI:SS AM'
    ) AS started_timestamp
FROM collect_tables;

alter table travel_transportation
add column started_timestamp timestamp;

update travel_transportation
set started_timestamp = TO_TIMESTAMP(
        REGEXP_REPLACE(
            REPLACE(
                REPLACE(started_date, ' at ', ' '),
                'UTC-4',
                ''
            ),
            '[[:space:]\u00A0\u202F]+',
            ' ',
            'g'
        ),
        'FMMonth DD, YYYY HH12:MI:SS AM'
    )
where started_date is not null;




-- date cleaning for ended_date
SELECT
    ended_date,
    TO_TIMESTAMP(
        REGEXP_REPLACE(
            REPLACE(
                REPLACE(ended_date, ' at ', ' '),
                'UTC-4',
                ''
            ),
            '[[:space:]\u00A0\u202F]+',
            ' ',
            'g'
        ),
        'FMMonth DD, YYYY HH12:MI:SS AM'
    ) AS ended_timestamp
FROM collect_tables;

alter table travel_transportation
add column ended_timestamp timestamp;

update travel_transportation
set ended_timestamp = TO_TIMESTAMP(
        REGEXP_REPLACE(
            REPLACE(
                REPLACE(ended_date, ' at ', ' '),
                'UTC-4',
                ''
            ),
            '[[:space:]\u00A0\u202F]+',
            ' ',
            'g'
        ),
        'FMMonth DD, YYYY HH12:MI:SS AM'
    )
where ended_date is not null;


-- null values or blank values
-- result: total ended_timestamp null is 109 and started_timestamp null is 0
select count(*) as total_rows,
       count(started_timestamp)as total_sta,
	   count(ended_timestamp) as total_end,
	   count(*) - count(started_timestamp) as total_sta_null,
	   count(*) - count(ended_timestamp)  as total_end_null
from collect_tables
-- inspecting the rows in stared_timestamp and ended_timestamp
select * from collect_tables
where started_timestamp is null
      or ended_timestamp is null
-- Rows with missing timestamps were preserved as NULL because no valid value existed in the source data
-- Kept missing ended_timestamp values as NULL because they were missing in the original dataset.
		 

-- remove any columns doesnt help and clean each table 
select * from travel_transportation
-- drop the messy started_date column
alter table travel_transportation
drop column started_date
-- drop the messy ended_date column
alter table travel_transportation
drop column ended_date
-- add cource_table column as category
alter table travel_transportation
add column sourse_table text
-- add value to the source_table column for each category
update travel_transportation
set sourse_table = 'travel_transportation'


-- clean view table final step removing all null rows 
create view final_collect_tables as
    select 'autos' as sourse_table , 
	        trends, 
			search_volume, 
			started_timestamp, 
			ended_timestamp, 
			trend_breakdown, 
			explore_link 
	from autos 
	where ended_timestamp is not null
	union all
	select 'beauty_fashion' as sourse_table ,
	       trends,
		   search_volume,
		   started_timestamp, 
		   ended_timestamp, 
		   trend_breakdown,
		   explore_link 
	from beauty_fashion 
	where ended_timestamp is not null
	union all
	select 'business_finance' as sourse_table, 
	       trends, 
		   search_volume, 
		   started_timestamp, 
		   ended_timestamp, 
		   trend_breakdown, 
		   explore_link 
	from business_finance
	where ended_timestamp is not null
	union all
	select 'climate' as sourse_table ,
	       trends, 
		   search_volume,
		   started_timestamp,
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from climate 
	where ended_timestamp is not null
	union all
	select 'entertainment' as sourse_table, 
	       trends,
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown,
		   explore_link  
	from entertainment
	where ended_timestamp is not null
	union all
	select 'food_drinks' as sourse_table, 
	       trends, 
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from food_drinks
	where ended_timestamp is not null
	union all
	select 'games' as sourse_table, 
	       trends,
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link
	from games 
	where ended_timestamp is not null
	union all
	select 'health' as sourse_table,
	       trends,
		   search_volume,
		   started_timestamp, 
		   ended_timestamp, 
		   trend_breakdown,
		   explore_link 
	from health 
	where ended_timestamp is not null
	union all
	select 'hobbies_leisure' as sourse_table,
	       trends, 
		   search_volume,
		   started_timestamp,
		   ended_timestamp, 
		   trend_breakdown, 
		   explore_link
	from hobbies_leisure 
	where ended_timestamp is not null
	union all
	select 'jobs_education' as sourse_table,
	       trends,
		   search_volume,
		   started_timestamp,
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from jobs_education 
	where ended_timestamp is not null
	union all
	select 'laws_government' as sourse_table , 
	       trends, 
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from laws_government
	where ended_timestamp is not null
	union all
	select 'others_search' as sourse_table,
	       trends, 
		   search_volume,
		   started_timestamp, 
		   ended_timestamp, 
		   trend_breakdown,
		   explore_link 
	from others_search
	where ended_timestamp is not null
	union all
	select 'pets_animals' as sourse_table,
	       trends,
		   search_volume,
		   started_timestamp,
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from pets_animals
	where ended_timestamp is not null
	union all
	select 'politics' as sourse_table, 
	       trends, 
		   search_volume,
		   started_timestamp,
		   ended_timestamp, 
		   trend_breakdown, 
		   explore_link 
	from politics
	where ended_timestamp is not null
	union all
	select 'science' as sourse_table ,
	       trends,
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown,
		   explore_link 
	from science 
	where ended_timestamp is not null
	union all
	select 'shopping' as sourse_table,
	       trends, 
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from shopping
	where ended_timestamp is not null
	union all
	select 'sports' as sourse_table,
	       trends, 
		   search_volume,
		   started_timestamp,
		   ended_timestamp,
		   trend_breakdown,
		   explore_link
	from sports 
	where ended_timestamp is not null
	union all
	select 'technology' as sourse_table, 
	       trends, 
		   search_volume,
		   started_timestamp, 
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from technology
	where ended_timestamp is not null
	union all
	select 'travel_transportation' as sourse_table,
	       trends, 
		   search_volume,
		   started_timestamp,
		   ended_timestamp,
		   trend_breakdown, 
		   explore_link 
	from travel_transportation 
	where ended_timestamp is not null;




-- final clean table has all data collected from all tables using union all
SELECT * FROM final_collect_tables;



--Cleaning Step	Status
     --Removed duplicate rows	
     --Trimmed whitespace	
     --Standardized search_volume	
     --Converted started_date to timestamp	
     --Converted ended_date to timestamp	
     --Preserved missing ended_date values as NULL	
     --Verified data types





















