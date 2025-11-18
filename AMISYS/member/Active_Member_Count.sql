- Active Member Count as of today

select count(distinct member_nbr)
from member_span ms
where to_char(sysdate, 'yyyymmdd') between substr(ymdeff,1,4) and substr(ymdend,1,4)
and void = ' ';