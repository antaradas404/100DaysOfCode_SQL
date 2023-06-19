# Write your MySQL query statement below
#creates a rank column-rankcol and a difference -diff column. 
#The diff column checks the difference between id and rankcol
#When consecutive diff values are same, they then have consecutive id values
with findiff as
(select * , (DENSE_RANK() OVER (ORDER BY id)) AS rankcol , id- (DENSE_RANK() OVER (ORDER BY id)) as diff
from Stadium
where people >= 100),
#adding a rownum for each of the values in a set of diff values
findrownum as
(select * , (ROW_NUMBER() OVER (PARTITION BY diff ORDER BY id)) as rownum
from findiff)

select id, visit_date, people from findrownum
where diff in 
#checking which set of diff values have more than 2 records
(select diff from findrownum
group by diff
having count(id)>2)
