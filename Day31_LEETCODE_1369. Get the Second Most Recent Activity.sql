# Write your MySQL query statement below
with temp as
(Select username, activity, startDate, endDate,
RANK() OVER (PARTITION BY username  ORDER BY username asc, endDate desc) as rnk,
count(1) OVER (PARTITION BY username ) as cnt
from UserActivity
)
select username, activity , startDate , endDate
from temp
where
case when cnt >1 then rnk=2
else rnk=1 end