select
  s.claim_type,
  ip.paid ip_paid,
  c.resolution,
  c.paid c_paid,
  c.explain_x,
  s.claim_nbr,
  s.member_nbr,
  s.aff_nbr,
  s.serv_nbr,
  s.line_ctr,
  s.ymdeff,
  s.ymdend,
  s.location,
  s.diag_nbr,
  s.diag2_nbr,
  s.diag3_nbr,
  s.diag4_nbr,
  s.proc_nbr,
  s.proc2_nbr,
  s.modifier,
  s.modifier2,
  s.modifier3,
  s.modifier4,
  s.amtcharge,
  s.amtcopay,
  s.amtdeduct,
  s.amtallow_p,
  s.amtpay,
  s.ex_array,
  s.paid s_paid,
  s.status_x,
  s.ymdrcvd,
  s.ymdtrans,
  s.ymdpaid,
  c.source,
  c.record_nbr,
  s.op_nbr,
  s2.claim_type,
  ip2.paid ip_paid,
  c2.resolution,
  c2.paid c_paid,
  c2.explain_x,
  s2.claim_nbr,
  s2.member_nbr,
  s2.aff_nbr,
  s2.serv_nbr,
  s2.line_ctr,
  s2.ymdeff,
  s2.ymdend,
  s2.location,
  s2.diag_nbr,
  s2.diag2_nbr,
  s2.diag3_nbr,
  s2.diag4_nbr,
  s2.proc_nbr,
  s2.proc2_nbr,
  s2.modifier,
  s2.modifier2,
  s2.modifier3,
  s2.modifier4,
  s2.amtcharge,
  s2.amtcopay,
  s2.amtdeduct,
  s2.amtallow_p,
  s2.amtpay,
  s2.ex_array,
  s2.paid s_paid,
  s2.status_x,
  s2.ymdrcvd,
  s2.ymdtrans,
  s2.ymdpaid,
  c2.source,
  c2.record_nbr,
  s2.op_nbr
from
  service_x s
  inner join claim c
  on s.claim_nbr = c.claim_nbr
  inner join service_x s2
  on s.member_nbr = s2.member_nbr
  and s.claim_nbr < s2.claim_nbr
  inner join claim c2
  on s2.claim_nbr = c2.claim_nbr
  left outer join in_process ip
  on c.claim_nbr = ip.claim_nbr
  left outer join in_process ip2
  on c2.claim_nbr = ip2.claim_nbr
where
  (s.ymdtrans between 19010101 and 99991231 or s2.ymdtrans between 19010101 and 99991231)
  and s.status_x = '30'
  and s2.status_x like '1%'
  and s.paid in ('*N')
  and c2.paid in ('NJ','NN','NY')
  and s2.paid in ('NN','NY')
--  and s.amtallow_p <> 0
  and s2.amtallow_p <> 0
  and c.resolution <> '39'
  and substr(c.resolution,1,1) not in ('4','9','5')
  and c2.resolution <> '39'
  and substr(c2.resolution,1,1) not in ('4','9','5')
  and s.claim_type = s2.claim_type
  and s.ymdeff = s2.ymdeff
  and substr(s.aff_nbr,1,12) = substr(s2.aff_nbr,1,12)
  and s.proc_nbr = s2.proc_nbr
  and s.proc2_nbr = s2.proc2_nbr
  and (
        (   
        (s.claim_type like 'M%' or s.claim_type like 'D%')
        and s.modifier in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        and s.modifier2 in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        and s.modifier3 in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        and s.modifier4 in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        )
      or
        (
        s.claim_type like 'H%'
        and s.diag_nbr = s2.diag_nbr
        and s.diag2_nbr = s2.diag2_nbr
        and s.diag3_nbr = s2.diag3_nbr
        and s.diag4_nbr = s2.diag4_nbr
        and s.proc2_nbr = s2.proc2_nbr
        )
      )
  and s.amtcharge = s2.amtcharge
union
select
  s.claim_type,
  ip.paid ip_paid,
  c.resolution,
  c.paid c_paid,
  c.explain_x,
  s.claim_nbr,
  s.member_nbr,
  s.aff_nbr,
  s.serv_nbr,
  s.line_ctr,
  s.ymdeff,
  s.ymdend,
  s.location,
  s.diag_nbr,
  s.diag2_nbr,
  s.diag3_nbr,
  s.diag4_nbr,
  s.proc_nbr,
  s.proc2_nbr,
  s.modifier,
  s.modifier2,
  s.modifier3,
  s.modifier4,
  s.amtcharge,
  s.amtcopay,
  s.amtdeduct,
  s.amtallow_p,
  s.amtpay,
  s.ex_array,
  s.paid s_paid,
  s.status_x,
  s.ymdrcvd,
  s.ymdtrans,
  s.ymdpaid,
  c.source,
  c.record_nbr,
  s.op_nbr,
  s2.claim_type,
  ip2.paid ip_paid,
  c2.resolution,
  c2.paid c_paid,
  c2.explain_x,
  s2.claim_nbr,
  s2.member_nbr,
  s2.aff_nbr,
  s2.serv_nbr,
  s2.line_ctr,
  s2.ymdeff,
  s2.ymdend,
  s2.location,
  s2.diag_nbr,
  s2.diag2_nbr,
  s2.diag3_nbr,
  s2.diag4_nbr,
  s2.proc_nbr,
  s2.proc2_nbr,
  s2.modifier,
  s2.modifier2,
  s2.modifier3,
  s2.modifier4,
  s2.amtcharge,
  s2.amtcopay,
  s2.amtdeduct,
  s2.amtallow_p,
  s2.amtpay,
  s2.ex_array,
  s2.paid s_paid,
  s2.status_x,
  s2.ymdrcvd,
  s2.ymdtrans,
  s2.ymdpaid,
  c2.source,
  c2.record_nbr,
  s2.op_nbr
from
  service_x s
  inner join claim c
  on s.claim_nbr = c.claim_nbr
  inner join service_x s2
  on s.member_nbr = s2.member_nbr
  and s.claim_nbr > s2.claim_nbr    -- reverse relationship of claim numbers
  inner join claim c2
  on s2.claim_nbr = c2.claim_nbr
  left outer join in_process ip
  on c.claim_nbr = ip.claim_nbr
  left outer join in_process ip2
  on c2.claim_nbr = ip2.claim_nbr
where
  (s.ymdtrans between 19010101 and 99991231 or s2.ymdtrans between 19010101 and 99991231)
  and s.status_x = '30'
  and s2.status_x like '1%'
  and s.paid in ('*N')
  and s2.paid in ('NN','NY')
--  and s.amtallow_p <> 0
  and c2.paid in ('NJ','NN','NY')
  and s2.amtallow_p <> 0
  and c.resolution <> '39'
  and substr(c.resolution,1,1) not in ('4','9','5')
  and c2.resolution <> '39'
  and substr(c2.resolution,1,1) not in ('4','9','5')
  and s.claim_type = s2.claim_type
  and s.ymdeff = s2.ymdeff
  and substr(s.aff_nbr,1,12) = substr(s2.aff_nbr,1,12)
  and s.proc_nbr = s2.proc_nbr
  and s.proc2_nbr = s2.proc2_nbr
  and (
        (   
        (s.claim_type like 'M%' or s.claim_type like 'D%')
        and s.modifier in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        and s.modifier2 in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        and s.modifier3 in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        and s.modifier4 in (s2.modifier,s2.modifier2,s2.modifier3,s2.modifier4)
        )
      or
        (
        s.claim_type like 'H%'
        and s.diag_nbr = s2.diag_nbr
        and s.diag2_nbr = s2.diag2_nbr
        and s.diag3_nbr = s2.diag3_nbr
        and s.diag4_nbr = s2.diag4_nbr
        and s.proc2_nbr = s2.proc2_nbr
        )
      )
  and s.amtcharge = s2.amtcharge
order by 
  9
;