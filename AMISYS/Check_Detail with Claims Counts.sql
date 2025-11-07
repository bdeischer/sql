-- list check detail including number of claims per check

exec :v_begin := '20230101';
exec :v_end := '20231231';

select * from 
(
  select
    cx.bank_check_nbr,
    cx.ymdpaid,
    count(distinct s.claim_nbr) claims,
    min(sa.payable_nbr),
    max(sa.payable_nbr),
    count(distinct sa.payable_nbr),
    min(sa.payable2),
    max(sa.payable2),
    count(distinct sa.payable2),
    min(cx.ymdpaid),
    min(cx.amountact) amountact,
    sum(sa.amt_apply) amtpay,
    sum(sai.amt_apply) amtinterest,
    max(nb.balance_p) negbal
  from check_x cx
  inner join service_acctng sa
  on cx.payable_nbr = sa.payable_nbr
  and sa.je_type like 'P%'
  left outer join service_acctng sai
  on sa.serv_nbr = sai.serv_nbr
  and sai.je_type like 'I%'
  inner join service_x s
  on sa.serv_nbr = s.serv_nbr
  left outer join eop_negbal nb
  on sa.payable2 = nb.payable_nbr
  where cx.ymdpaid between :v_begin and :v_end
  group by cx.bank_check_nbr,
           cx.ymdpaid
  order by 1
) ;