select b.book_id, b.name
from books b left join Orders o 
on b.book_id=o.book_id
and DATEDIFF('2019/06/23', coalesce(o.dispatch_date,'2019/06/23')) <=365
where DATEDIFF('2019/06/23', b.available_from)>31
group by 1,2
having(coalesce(sum(quantity),0)<10)
