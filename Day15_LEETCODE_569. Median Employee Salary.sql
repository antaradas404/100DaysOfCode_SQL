# Write your MySQL query statement below
with temp as
(select id , company , salary ,
# sorting the records in ascending and descending order to get matching rowid between both the columns

#id asc-id is sorted in asc order by default
(row_number() OVER (PARTITION BY company order by company asc,salary asc  /*, id asc*/ ) ) ascrowid,

#id desc- to ensure that the median record has ascrowid=descrowid when total number of records is odd
(row_number() OVER (PARTITION BY company order by company desc,salary desc, id desc) ) descrowid

from Employee)

select id , company , salary 
from temp 
where  ascrowid in (descrowid , descrowid+1 , descrowid-1)
