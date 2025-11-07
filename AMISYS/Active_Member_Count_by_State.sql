-- This script creates a count of members by state
--  disclaimer - if a member has more than 1 address record in different states, that member is counted more than once

select state, count(*) from 
(
select distinct ms.member_nbr,state
from amiown.member_span ms
inner join amiown.address a
on trim(addrtype_who) = 'D   S ' || substr(member_nbr,1,9)
and a.void = ' '
and to_char(sysdate,'YYYYMMDD') between a.ymdeff and a.ymdend
where ms.void = ' '
  and to_char(sysdate, 'yyyymmdd') between ms.ymdeff and ms.ymdend
) a 
group by state
order by 1
;