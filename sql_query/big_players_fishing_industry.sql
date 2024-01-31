with 
cumulated_capture_production 			as
(
select
	entity
	,sum(capture_fisheries_production_metric_tons) 		    						as cumulated_capture_fisheries_production_metric_tons
from capture_fishery_production
group by entity
),
cumulated_aquaculture_fish_production 	as
(
select
	entity
	,sum(aquaculture_production_metric_tons) 										as cumulated_aquaculture_farmed_fish_production_metric_tons
from aquaculture_farmed_fish_production
group by 1
)
SELECT 
    	cfp.entity																	,
    	cfp.cumulated_capture_fisheries_production_metric_tons						,
    	affp.cumulated_aquaculture_farmed_fish_production_metric_tons				,
		(cfp.cumulated_capture_fisheries_production_metric_tons	
			 + affp.cumulated_aquaculture_farmed_fish_production_metric_tons) 		as total_cumulated_production
	from cumulated_capture_production cfp
inner join cumulated_aquaculture_fish_production affp on cfp.entity = affp.entity
order by total_cumulated_production asc
 
