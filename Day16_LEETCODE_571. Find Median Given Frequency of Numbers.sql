# Write your MySQL query statement below

# Decompressing table using Recursive CTE
With recursive temp1 as
(
   Select num, frequency , 1 as cnt
   from Numbers
   union all
   Select num, frequency , cnt+1 as cnt
   from  temp1
   where cnt < frequency
),

# Finding median values
temp2 as (select num, frequency , cnt , (row_number() over (order by num asc, cnt asc )) rasc, (row_number() over (order by num desc, cnt desc )) rdesc
from temp1
order by num, cnt)

Select  round(sum(num)/count(num), 1) as median 
from temp2
where rasc in (rdesc, rdesc+1 , rdesc-1)