with temp as(
# Counting the number of players that logged in for at least two consecutive days starting from their first login date
Select * from Activity where (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) in
(Select player_id, min(event_date)
from Activity
group by player_id)
)

select round( count(player_id) / (select count(distinct player_id )  from Activity), 2) as fraction
from temp