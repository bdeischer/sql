select * from service_x where claim_nbr in (
select distinct
  s.claim_nbr
from
  service_x s
  left outer join service_x s2
  on s.claim_nbr = s2.claim_nbr
  and substr(s2.serv_nbr,1,14) = substr(s.serv_nbr,1,14)
  and substr(s2.serv_nbr,15,2) < substr(s.serv_nbr,15,2)
where 
  s2.claim_nbr is null
  and substr(s.serv_nbr,15,2) <> '00'
)
order by
  3
;