with alldates as
(
select 'succeeded' as period_state , success_date as start_date
from Succeeded
where success_date between '2019-01-01' and '2019-12-31'
union all
select 'failed' as period_state, fail_date as start_date
from Failed
where fail_date between '2019-01-01' and '2019-12-31'
),

daterank as 
(
select period_state, start_date , 

# The difference between row_number based on date, and row_number based on period_state and date would define the groups with same rnk , which can be used for group by clause later
(row_number () over (order by start_date) - row_number () OVER (partition by period_state order by start_date) )as rnk

from alldates
order by start_date
)

select period_state , min(start_date ) as start_date  , max(start_date ) as end_date     
from daterank
group by period_state,rnk


