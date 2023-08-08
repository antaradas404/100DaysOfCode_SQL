# Write your MySQL query statement below
with temp as 
(select managerId  
from Employee
group by managerId 
having count(id) >4) 
select e.name from Employee e, temp t 
where e.id = t.managerId