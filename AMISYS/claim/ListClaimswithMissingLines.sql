select * from service_x where claim_nbr in (
select distinct
  s.claim_nbr
from
  service_x s
where 
  substr(s.serv_nbr,15,2) <> '00'
  and not exists
    (
    select 
      1
    from
      service_x
    where
      claim_nbr = s.claim_nbr
      and serv_nbr = substr(s.serv_nbr,1,14)||to_char(substr(s.serv_nbr,15,2)-1,'FM00')
    )
)
order by
  3
;
