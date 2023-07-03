# Write your MySQL query statement below
with banned as
(select users_id from Users where banned='Yes'),
cancelled as
(select count(id) as cancelledcount , request_at from Trips t
where t.client_id not in (SELECT users_id FROM banned)
and  t.driver_id not in (SELECT users_id FROM banned)
and status like 'cancelled%'
and request_at between "2013-10-01" and "2013-10-03"
group by request_at
),
totaltrips as
(select count(id) as totalcount, request_at from Trips t
where t.client_id not in (SELECT users_id FROM banned)
and  t.driver_id not in (SELECT users_id FROM banned)
and request_at between "2013-10-01" and "2013-10-03"
group by request_at
)
select t.request_at as 'Day'  , round(COALESCE(cancelledcount/ totalcount, 0), 2) as "Cancellation Rate"
from totaltrips t left join cancelled c 
on t.request_at= c.request_at