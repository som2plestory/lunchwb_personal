select menu_no 
from(select m.menu_no 
    from store s, menu m 
    where s.menu_2nd_cate_no=m.menu_2nd_cate_no 
    and s.store_no = 3219 
    order by dbms_random.value) 
where rownum <=1;
