/*
Enter your query here.
*/
with temp as 
(select x, y , ROW_NUMBER() OVER() as row_num from FUNCTIONS)
SELECT distinct t1.x, t1.y 
FROM temp as t1, temp as t2
where t1.x=t2.y
and t1.y=t2.x
and t1.x <= t1.y
and t1.row_num != t2.row_num
order by  t1.x
