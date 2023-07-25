# Write your MySQL query statement below
# Grouping for multiple calls between the same pair of people 

# Using logic to have from_id< to_id, for easy grouping
select  least(from_id, to_id) as person1,
greatest(from_id, to_id) as person2,
count(duration) as call_count,  
sum(duration) as total_duration 
from Calls
group by  person1, person2
order by person1, person2