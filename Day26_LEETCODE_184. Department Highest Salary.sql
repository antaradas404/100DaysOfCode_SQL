# Write your MySQL query statement below
with temp as
(Select id, departmentId, name, salary, DENSE_RANK() OVER (PARTITION BY departmentId order by salary desc ) as rankk
from Employee e
order by departmentId,rankk, id
)
Select d.name as Department, t.name as Employee , t.salary as Salary 
from temp t join Department  d
on t.departmentId = d.id
where t.rankk=1

