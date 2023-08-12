# Write your MySQL query statement below
with temp1 as
(
Select l1.user_id as user_id,  l2.user_id as recommended_id
from Listens l1 join Listens l2 
on l1.song_id= l2.song_id and l1.day = l2.day and l1.user_id  != l2.user_id and  l1.user_id< l2.user_id 
group by  l1.user_id , l2.user_id , l1.day
having count(distinct l1.song_id ) >= 3
),

temp2 as
( select user_id, recommended_id from temp1 t
left join friendship f 
on t.user_id= f.user1_id and t.recommended_id= f.user2_id 
where f.user1_id is null
)

select user_id, recommended_id from temp2 
union
select recommended_id, user_id from temp2 