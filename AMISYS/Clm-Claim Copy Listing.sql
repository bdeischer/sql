Listing both original claim and copied claim

select distinct 
       si.sccf_nbr as orig_sccf_nbr,
       si1.sccf_nbr as copied_sccf_nbr,
       c.claim_nbr as orig_claim_nbr,
       clx.claim_nbr as copied_claim_nbr,
       to_char(sum(s.amtcharge/100),'L999G999G999D99') as orig_amtcharge,
       to_char(a.amtcharge/100,'L999G999G999D99') as copied_amtcharge,       
       to_char(sum(s.amtallow_b/100),'L999G999G999D99') as orig_amtallow_b,
       to_char(a.amtallow_b/100,'L999G999G999D99') as copied_amtallow_b,       
       to_char(sum(s.amtallow_p/100),'L999G999G999D99') as orig_amtallow_p,
       to_char(a.amtallow_p/100,'L999G999G999D99') as copied_amtallow_p,
       to_char(sum(s.amtppd/100),'L999G999G999D99') as orig_amtppd,
       to_char(a.amtppd/100,'L999G999G999D99') as copied_amtppd,
       to_char(sum(s.amtdeduct/100),'L999G999G999D99') as orig_amtdeduct,
       to_char(a.amtdeduct/100,'L999G999G999D99') as copied_amtdeduct,
       to_char(sum(s.amtcopay/100),'L999G999G999D99') as orig_amtcopay,
       to_char(a.amtcopay/100,'L999G999G999D99') as copied_amtcopay,
       to_char(sum(s.amtcoins/100),'L999G999G999D99') as orig_amtcoins,
       to_char(a.amtcoins/100,'L999G999G999D99') as copied_amtcoins,
       to_char(sum(s.amtpay/100),'L999G999G999D99') as orig_amtpay,
       to_char(a.amtpay/100,'L999G999G999D99') as copied_amtpay,
       to_char(sum(s.amtinterest/100),'L999G999G999D99') as orig_amtinterest,
       to_char(a.amtinterest/100,'L999G999G999D99') as copied_amtinterest,
       c.ymdtrans as last_time_orig_claim_touched,
       c1.ymdtrans as last_time_copy_claim_touched
from claim c
inner join clxref clx on c.claim_nbr = clx.clxref_nbr
inner join service_x s on c.claim_nbr = s.claim_nbr
inner join claim c1 on c1.claim_nbr = clx.claim_nbr
inner join 
(
    select distinct 
           claim_nbr,
           sccf_nbr
      from servicei 
) si
on si.claim_nbr = c.claim_nbr
inner join 
(
    select distinct 
           claim_nbr,
           sccf_nbr
      from servicei 
) si1
on si1.claim_nbr = clx.claim_nbr
inner join 
(
    select claim_nbr, 
           sum(amtcharge) amtcharge,
           sum(amtallow_b) amtallow_b,
           sum(amtallow_p) amtallow_p,
           sum(amtppd) amtppd,
           sum(amtdeduct) amtdeduct,
           sum(amtcopay) amtcopay,
           sum(amtcoins) amtcoins,
           sum(amtpay) amtpay,
           sum(amtinterest) amtinterest
      from service_x
      group by claim_nbr
) a
on a.claim_nbr = clx.claim_nbr
-- where c.claim_nbr = '230190000014'
group by si.sccf_nbr,
         si1.sccf_nbr,
         c.claim_nbr, 
         clx.claim_nbr, 
         to_char(a.amtcharge/100,'L999G999G999D99'), 
         to_char(a.amtallow_b/100,'L999G999G999D99'),
         to_char(a.amtallow_p/100,'L999G999G999D99'), 
         to_char(a.amtppd/100,'L999G999G999D99'),
         to_char(a.amtdeduct/100,'L999G999G999D99'),
         to_char(a.amtcopay/100,'L999G999G999D99'), 
         to_char(a.amtcoins/100,'L999G999G999D99'),
         to_char(a.amtpay/100,'L999G999G999D99'), 
         to_char(a.amtinterest/100,'L999G999G999D99'),
         c.ymdtrans,
         c1.ymdtrans         
;