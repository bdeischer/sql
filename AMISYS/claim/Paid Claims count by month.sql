-- lists count of claims by month

select
  substr(ymdpaid,1,6) paid_month,
  count(distinct claim_nbr) claims
from service_x
group by substr(ymdpaid,1,6)
order by 1
;