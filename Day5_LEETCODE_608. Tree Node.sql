# Write your MySQL query statement below
#Finding id for root
with troot as
(select id,p_id, 'Root' as type   from tree where id in (select id from tree where p_id is null)),
#Finding id for leaf
tleaf as
(select id,p_id, 'Leaf' as type   from tree 
where id not in (select distinct p_id from tree where p_id is not null )
and id not in (select id from troot)
),
#Finding id for inner
tinner as
(select id,p_id, 'Inner' as type   from tree where id not in 
(select id from troot 
union 
select id from tleaf 
 )
)

select id, type from troot
union
select id, type from tinner
union
select id, type from tleaf