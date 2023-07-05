/*
Enter your query here.
*/
/* Tables-Company, Lead_Manager,Senior_Manager, Manager, Employee
Output cols- company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees */
Select c.company_code, founder, count(distinct lm.lead_manager_code) , count( distinct sm.senior_manager_code), count( distinct m.manager_code), count(distinct e.employee_code)
from Company c
inner join Lead_Manager lm
on c.company_code= lm.company_code
inner join Senior_Manager sm
on lm.lead_manager_code= sm.lead_manager_code
inner join Manager m
on sm.senior_manager_code= m.senior_manager_code
inner join Employee e
on m.manager_code= e.manager_code
group by c.company_code, founder
order by c.company_code