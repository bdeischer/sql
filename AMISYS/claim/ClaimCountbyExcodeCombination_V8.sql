var pymdpaid number;
exec :pymdpaid := 20251101;

select b.explain_codes, 
       b.explain_code_desc,
       count(*)  COUNT,
       round(100*ratio_to_report(count(*)) over (), 2) PERCENTAGE      
from 
(
with a (claim_nbr, exc, cdesc )
as
(
   select distinct substr(ph.record_key,3,12) claim_nbr , substr(cd1.code_nbr,3,2) exc, cd1.description cdesc
     from amiown.process_hist ph
     inner join amiown.service_x sx
     on substr(ph.record_key,3,16) = sx.serv_nbr
     and substr(sx.serv_nbr,13,4) = '0100'
     and sx.ymdpaid > :pymdpaid
     inner join amiown.code_detail cd1
     on cd1.code_nbr in (cast('EX' || substr(ph.free_form_data,16,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,18,2) as char(04)), 
                         cast('EX' || substr(ph.free_form_data,20,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,22,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,24,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,26,2) as char(04)))
     and substr(cd1.description2,55,4) = 'PEND'
     and substr(ph.op_nbr,1,3) <> 'SYS' and substr(ph.op_nbr,1,1)<> 'X' 
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , substr(cd2.code_nbr,3,2) exc, cd2.description cdesc
     from amiown.process_hist ph
     inner join amiown.service_x sx2
     on substr(ph.record_key,3,16) = sx2.serv_nbr
     and substr(sx2.serv_nbr,13,4) = '0100'
     and sx2.ymdpaid > :pymdpaid
     inner join amiown.code_detail cd2
     on cd2.code_nbr in (cast('EX' || substr(ph.free_form_data,16,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,18,2) as char(04)), 
                         cast('EX' || substr(ph.free_form_data,20,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,22,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,24,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,26,2) as char(04)))
     and substr(cd2.description2,55,4) = 'PEND'
     and substr(ph.op_nbr,1,3) <> 'SYS' and substr(ph.op_nbr,1,1)<> 'X' 
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , substr(cd3.code_nbr,3,2) exc, cd3.description cdesc
     from amiown.process_hist ph
     inner join amiown.service_x sx3 
     on substr(ph.record_key,3,16) = sx3.serv_nbr
     and substr(sx3.serv_nbr,13,4) = '0100'
     and sx3.ymdpaid > :pymdpaid
     inner join amiown.code_detail cd3
     on cd3.code_nbr in (cast('EX' || substr(ph.free_form_data,16,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,18,2) as char(04)), 
                         cast('EX' || substr(ph.free_form_data,20,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,22,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,24,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,26,2) as char(04)))
     and substr(cd3.description2,55,4) = 'PEND'
     and substr(ph.op_nbr,1,3) <> 'SYS' and substr(ph.op_nbr,1,1)<> 'X' 
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , substr(cd4.code_nbr,3,2) exc, cd4.description cdesc
     from amiown.process_hist ph
     inner join amiown.service_x sx4
     on substr(ph.record_key,3,16) = sx4.serv_nbr
     and substr(sx4.serv_nbr,13,4) = '0100'
     and sx4.ymdpaid > :pymdpaid
     inner join amiown.code_detail cd4
     on cd4.code_nbr in (cast('EX' || substr(ph.free_form_data,16,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,18,2) as char(04)), 
                         cast('EX' || substr(ph.free_form_data,20,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,22,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,24,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,26,2) as char(04)))
     and substr(cd4.description2,55,4) = 'PEND'
     and substr(ph.op_nbr,1,3) <> 'SYS' and substr(ph.op_nbr,1,1)<> 'X' 
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , substr(cd5.code_nbr,3,2) exc, cd5.description cdesc
     from amiown.process_hist ph
     inner join amiown.service_x sx5
     on substr(ph.record_key,3,16) = sx5.serv_nbr
     and substr(sx5.serv_nbr,13,4) = '0100'
     and sx5.ymdpaid > :pymdpaid
     inner join amiown.code_detail cd5
     on cd5.code_nbr in (cast('EX' || substr(ph.free_form_data,16,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,18,2) as char(04)), 
                         cast('EX' || substr(ph.free_form_data,20,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,22,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,24,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,26,2) as char(04)))
     and substr(cd5.description2,55,4) = 'PEND'
     and substr(ph.op_nbr,1,3) <> 'SYS' and substr(ph.op_nbr,1,1)<> 'X' 
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , substr(cd6.code_nbr,3,2) exc, cd6.description cdesc
     from amiown.process_hist ph
     inner join amiown.service_x sx6
     on substr(ph.record_key,3,16) = sx6.serv_nbr
     and substr(sx6.serv_nbr,13,4) = '0100'
     and sx6.ymdpaid > :pymdpaid
     inner join amiown.code_detail cd6
     on cd6.code_nbr in (cast('EX' || substr(ph.free_form_data,16,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,18,2) as char(04)), 
                         cast('EX' || substr(ph.free_form_data,20,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,22,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,24,2) as char(04)),
                         cast('EX' || substr(ph.free_form_data,26,2) as char(04)))
     and substr(cd6.description2,55,4) = 'PEND'
     and substr(ph.op_nbr,1,3) <> 'SYS' and substr(ph.op_nbr,1,1)<> 'X' 
)
select distinct
       claim_nbr,
       cast(listagg(a.exc,',') within group (order by a.exc) as char(30)) EXPLAIN_CODES,
       cast(listagg(a.cdesc,',') within group (order by a.cdesc) as char(400)) EXPLAIN_CODE_DESC
from a
group by a.claim_nbr
) b
group by explain_codes, explain_code_desc
;
