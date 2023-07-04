# Write your MySQL query statement below
with trowid as(
Select id, student , (id+1) as rowid
from Seat
where id % 2 !=0
union
select  id, student , (id-1) as rowid 
from Seat
where id % 2 =0
)

select t1.id, COALESCE(t2.student , t1.student) as student 
from trowid t1 left outer join trowid t2
on t1.id= t2.rowid
order by id