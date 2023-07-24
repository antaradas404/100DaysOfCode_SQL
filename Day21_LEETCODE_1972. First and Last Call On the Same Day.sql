# Write your MySQL query statement below
with temp1 as
(   # Generating table as :  id | otherid | call_time | call_date 
    # primaryid for a caller has records for both when it was a caller as well as a recepient
select caller_id as id , recipient_id  as otherid, call_time , date(call_time)   as call_date  from Calls
union all
select recipient_id  as id , caller_id  as otherid, call_time , date(call_time)   as call_date  from Calls
),

temp2 as
(   # Generating table as :   primaryid | othercallerid | call_time | call_date  | CallnNumberASC | CallnNumberDSC
    # CallnNumberDSC is reverese of CallnNumberASC rank values , 
    # used to fetch the first and the last call records for the day for an id
select id as primaryid, otherid as othercallerid, call_time  , call_date, 
ROW_NUMBER() OVER( PARTITION BY id,call_date order by call_time ) as CallnNumberASC,
ROW_NUMBER() OVER( PARTITION BY id,call_date order by call_time desc) as CallnNumberDSC
from temp1 order by id ,  call_time 
)

select distinct primaryid as user_id from temp2
# Fetching the first and the last call records  only for the day for an id
where CallnNumberASC =1 or CallnNumberDSC =1 
# To get records which have the same othercallerid for both the first and the last call 
group by primaryid, call_date having count(distinct othercallerid)=1