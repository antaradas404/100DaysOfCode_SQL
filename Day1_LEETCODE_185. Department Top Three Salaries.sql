# Write your MySQL query statement below
With temp as 
(select d.name as Department , e.name as Employee, e.salary as Salary,
DENSE_RANK() OVER ( PARTITION BY e.departmentId ORDER BY e.salary DESC  ) as emprank
from Employee e, Department  d
where e.departmentId = d.id
)
Select Department, Employee, Salary from temp
where emprank<4