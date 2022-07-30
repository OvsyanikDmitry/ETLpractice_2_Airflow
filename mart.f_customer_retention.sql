CREATE or REPLACE VIEW mart.f_customer_retention AS
with a as (
select dc.week_of_year as period_id,
item_id,customer_id,payment_amount,status
from mart.f_sales s
join mart.d_calendar dc 
on s.date_id = dc.date_id ),
		b as (
			select customer_id, 
			count(distinct case when status='shipped' then item_id end) buy,
			count(distinct case when status='refunded' then item_id end) returned
			from mart.f_sales 
			group by 1
				)
				select 
				count(distinct case when b.buy = 1 then b.customer_id end) as new_customers_count, 
				count(distinct case when b.buy > 1 then b.customer_id end) as returning_customers_count, 
				count(distinct case when a.status='refunded' then a.customer_id end) as refunded_customer_count,
				'weekly' period_name,
				a.period_id,
				a.item_id,
				sum(case when b.buy = 1 then a.payment_amount end) as new_customers_revenue,
				sum(case when b.buy > 1 then a.payment_amount end) as returning_customers_revenue,
				count(case when a.status='refunded' then a.status end) as customers_refunded
				from a
				join b on a.customer_id = b.customer_id  
				group by a.period_id,a.item_id
;