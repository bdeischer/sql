-- This query lists and then deletes duplicate member records

select member_nbr, ws_cnt from
  (
     select member_nbr, count(*) as ws_cnt from amiown.member group by member_nbr
  ) m1
where m1.ws_cnt > 1;

OR

select member_nbr, count(*)
from member
group by member_nbr
having count(*) > 1;

-- Delete the duplicates and leave the most recent by image_recnbr

delete from member m
  where m.image_recnbr not in 
    (
        select max(image_recnbr)
          from member m1
          where m.member_nbr = m1.member_nbr 
    );
    