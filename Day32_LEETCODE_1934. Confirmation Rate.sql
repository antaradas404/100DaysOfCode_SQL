# Write your MySQL query statement below
#The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.
#Write a solution to find the confirmation rate of each user.

Select s.user_id , 
ROUND ( COALESCE(SUM(CASE WHEN action= 'confirmed' THEN 1 ELSE 0 END)/ COUNT(action) , 0), 2) as confirmation_rate
from Signups s left join Confirmations c on c.user_id=s.user_id
group by s.user_id  order by s.user_id