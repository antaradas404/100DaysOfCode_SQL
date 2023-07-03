# Write your MySQL query statement below
with temp as
(select salary, ROW_NUMBER() OVER ( ORDER BY salary desc) as SecondHighestSalary from Employee group by salary )
#ROW_NUMBER-To not have multiple outputs for 2nd highest
# group by - To print null if all records have same salary 
SELECT COALESCE((Select salary from temp where SecondHighestSalary=2), NULL) AS SecondHighestSalary;
#To print null if query fetches no output


