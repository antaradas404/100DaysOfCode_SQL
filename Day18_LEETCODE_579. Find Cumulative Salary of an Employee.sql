# Write your MySQL query statement below
with tempmax as(
  select max(month ) maxmonth , id
  from Employee
  group by id
)
select e1.id, e1.month, coalesce(sum(e2.salary) ) as Salary  from Employee e1 , Employee e2 , tempmax t
where e1.id=e2.id 
and e1.id=t.id 
and e2.month in (e1.month, e1.month-1, e1.month-2)
and e1.month != t.maxmonth
group by  e1.id, e1.month
order by id, month desc