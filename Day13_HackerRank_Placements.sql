/*
Enter your query here.
*/
with temp as(
select s.ID, s.Name, f.Friend_ID, p.Salary
from Students s 
inner join Friends f on s.ID = f.ID
inner join Packages p on s.ID = p.ID
    ),
temp2 as
( select t.ID, t.Name, t.Friend_ID, t.Salary, p.Salary as FriendSalary
from temp t inner join Packages p on t.Friend_ID= p.ID
)
select Name from temp2
where Salary<FriendSalary
order by FriendSalary