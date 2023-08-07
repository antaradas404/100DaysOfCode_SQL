# Write your MySQL query statement below
with temp as
(select exam_id ,student_id ,score , 
RANK() OVER (PARTITION BY exam_id order by score asc) as RANKASC ,
RANK() OVER (PARTITION BY exam_id order by score desc) as RANKDESC 
from
exam
)
select distinct t1.student_id , s.student_name
from temp t1 left join 
(select distinct student_id from temp where RANKASC = 1 or RANKDESC = 1) t2
on t1.student_id= t2.student_id
join student s
on t1.student_id= s.student_id
where t1.RANKASC != 1 and t1.RANKDESC != 1
and t2.student_id is null
order by t1.student_id

