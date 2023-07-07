# Write your MySQL query statement below
with temp1 as
(select requester_id as id, count(*) as cnt
from RequestAccepted
group by requester_id) ,
temp2 as
(select accepter_id as id , count(*) as cnt
from RequestAccepted
group by accepter_id) ,

temp3 as
(
select id, sum(cnt) as num

from(
select * from temp1
union all
select * from temp2 
) a
group by id
)

select id, num
from temp3 
group by id, num
having num = (select max(num) from temp3)
