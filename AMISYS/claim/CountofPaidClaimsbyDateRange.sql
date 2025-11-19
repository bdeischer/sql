var begin_ymdpaid number;
var end_ymdpaid number;

exec :begin_ymdpaid := 20231101;
exec :end_ymdpaid := 20231130;

select
  op_nbr, 
  count(distinct claim_nbr) claims
from service_x
where ymdpaid between :begin_ymdpaid and :end_ymdpaid
group by
  op_nbr
order by 1
;

select
  count(distinct claim_nbr) claims
from service_x
where ymdpaid between :begin_ymdpaid and :end_ymdpaid
order by 1
;

select 
       case 
          when op_nbr = 'SYS' or substr(op_nbr,1,1) = 'X' then 'SYS or X'
          else 'Not SYS or X'
       end counto,
       count(distinct claim_nbr)
from service_x 
where ymdpaid between :begin_ymdpaid and :end_ymdpaid
group by case 
           when op_nbr = 'SYS' or substr(op_nbr,1,1) = 'X' then 'SYS or X'
           else 'Not SYS or X'
         end
;