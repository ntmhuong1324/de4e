select *
from `5000_sale_orders_cat_tax_csv` soctc 



select region, count(`Order ID`)
from `5000_sale_orders_csv` soc 
group by Region 


select region, sum(`Total Revenue`)
from `5000_sale_orders_csv` soc 
group by Region 
order by `Total Revenue` desc 


select region, sum(`Total Revenue`)
from `5000_sale_orders_csv` soc 
where region = 'Asia' 
	or region = 'Europe'
group by Region 


select soc.Region ,soc.Country , soc.`Order ID`, somc.Manager ,somc.Address  
from `5000_sale_orders_csv` soc 
left join `5000_sale_orders_managers_csv` somc 
on soc.Region = somc.Region 


select soc.Region, somc.Manager , count(soc.`Order ID`) as num_order
	from `5000_sale_orders_csv` soc
	left join `5000_sale_orders_managers_csv` somc
	on soc.Region = somc.Region 
	group by Region
	order by Num_order desc limit 1
	
	
	
	-- truong hop dung Max
with order_by_region as (
	select soc.Region, somc.Manager , count(soc.`Order ID`) as num_order
	from `5000_sale_orders_csv` soc
	left join `5000_sale_orders_managers_csv` somc
	on soc.Region = somc.Region 
	group by Region
)
select * 
from order_by_region o
where num_order = (select max(oo.num_order) from order_by_region oo)