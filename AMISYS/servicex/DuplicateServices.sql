with dup_claim_pairs as
(
select
  s.claim_type,
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
  s.ex_array,
  s.amtcharge,
  s.amtallow_p,
  s.amtpay,
  c.resolution,
  c.paid c_paid,
  s.paid,
  s.status_x,
  s.ymdrcvd,
  s.ymdpaid,
  c.source,
  c.record_nbr,
  s.op_nbr,
  s2.claim_type claim_type_1,
  s2.claim_nbr claim_nbr_1,
  s2.member_nbr member_nbr_1,
  s2.aff_nbr aff_nbr_1,
  s2.serv_nbr serv_nbr_1,
  s2.line_ctr line_ctr_1,
  s2.ymdeff ymdeff_1,
  s2.ymdend ymdend_1,
  s2.location location_1,
  s2.diag_nbr diag_nbr_1,
  s2.diag2_nbr diag2_nbr_1,
  s2.diag3_nbr diag3_nbr_1,
  s2.diag4_nbr diag4_nbr_1,
  s2.proc_nbr proc_nbr_1,
  s2.proc2_nbr proc2_nbr_1,
  s2.modifier modifier_1,
  s2.modifier2 modifier2_1,
  s2.modifier3 modifier3_1,
  s2.modifier4 modifier4_1,
  s2.ex_array ex_array_1,
  s2.amtcharge amtcharge_1,
  s2.amtallow_p amtallow_p_1,
  s2.amtpay amtpay_1,
  c2.resolution resolution_1,
  c2.paid c_paid_1,
  s2.paid paid_1,
  s2.status_x status_x_1,
  s2.ymdrcvd ymdrcvd_1,
  s2.ymdpaid ymdpaid_1,
  c2.source source_1,
  c2.record_nbr record_nbr_1,
  s2.op_nbr op_nbr_1
from
  service_x s
  inner join claim c
  on s.claim_nbr = c.claim_nbr
  inner join service_x s2
  on s.member_nbr = s2.member_nbr
  and s.claim_nbr < s2.claim_nbr
  inner join claim c2
  on s2.claim_nbr = c2.claim_nbr
where
  s.status_x like '1%'
  and s2.status_x like '1%'
  and s.claim_type = s2.claim_type
  and s.ymdeff = s2.ymdeff
  and s.aff_nbr = s2.aff_nbr
  and s.proc_nbr = s2.proc_nbr
  and (
        (   
        s.claim_type like 'M%' 
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
  and s.modifier = s2.modifier
  and s.modifier2 = s2.modifier2
  and s.modifier3 = s2.modifier3
  and s.modifier4 = s2.modifier4
  and s.amtcharge = s2.amtcharge
order by 
  s.serv_nbr
)
select
  claim_nbr
from
  dup_claim_pairs
where
  c_paid in ('NN','NJ')
union
select
  claim_nbr_1
from
  dup_claim_pairs
where
  c_paid_1 in ('NN','NJ')
;
  
  
  