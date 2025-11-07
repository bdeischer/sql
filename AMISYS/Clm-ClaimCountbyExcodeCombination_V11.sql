var pymdrcvd number;
exec :pymdrcvd := 20251101;

select b.explain_codes, 
       b.explain_code_desc,
       count(*)  COUNT,
       round(100*ratio_to_report(count(*)) over (), 2) PERCENTAGE      
from 
(with a (claim_nbr, exc, cdesc )
as
(
   select distinct substr(ph.record_key,3,12) claim_nbr , ec1.explain_x exc, ec1.description cdesc
     from amiown.process_hist ph
     inner join service_x sx
     on substr(ph.record_key,3,18) = sx.serv_nbr
     and substr(sx.serv_nbr,13,6) = '000100'
     and sx.ymdrcvd > :pymdrcvd
     left outer join amiown.explain_code ec1
     on ec1.explain_x = substr(ph.free_form_data,16,4)
     and ec1.serv_pay_status = 'PEND'
--     and rownum < 10
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , ec2.explain_x exc, ec2.description cdesc
     from amiown.process_hist ph
     inner join service_x sx2
     on substr(ph.record_key,3,18) = sx2.serv_nbr
     and substr(sx2.serv_nbr,13,6) = '000100'
     and sx2.ymdrcvd > :pymdrcvd
     left outer join amiown.explain_code ec2
     on ec2.explain_x = substr(ph.free_form_data,16,4)
     and ec2.serv_pay_status = 'PEND'
--     and rownum < 10     
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , ec3.explain_x exc, ec3.description cdesc
     from amiown.process_hist ph
     inner join service_x sx3 
     on substr(ph.record_key,3,18) = sx3.serv_nbr
     and substr(sx3.serv_nbr,13,6) = '000100'
     and sx3.ymdrcvd > :pymdrcvd
     left outer join amiown.explain_code ec3
     on ec3.explain_x = substr(ph.free_form_data,16,4)
     and ec3.serv_pay_status = 'PEND'
--     and rownum < 10     
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , ec4.explain_x exc, ec4.description cdesc
     from amiown.process_hist ph
     inner join service_x sx4
     on substr(ph.record_key,3,18) = sx4.serv_nbr
     and substr(sx4.serv_nbr,13,6) = '000100'
     and sx4.ymdrcvd > :pymdrcvd
     left outer join amiown.explain_code ec4
     on ec4.explain_x = substr(ph.free_form_data,16,4)
     and ec4.serv_pay_status = 'PEND'
--          and rownum < 10
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , ec5.explain_x exc, ec5.description cdesc
     from amiown.process_hist ph
     inner join service_x sx5
     on substr(ph.record_key,3,18) = sx5.serv_nbr
     and substr(sx5.serv_nbr,13,6) = '000100'
     and sx5.ymdrcvd > :pymdrcvd
     left outer join amiown.explain_code ec5
     on ec5.explain_x = substr(ph.free_form_data,16,4)
     and ec5.serv_pay_status = 'PEND'
--          and rownum < 100
   union  
   select distinct substr(ph.record_key,3,12) claim_nbr , ec6.explain_x exc, ec6.description cdesc
     from amiown.process_hist ph
     inner join service_x sx6
     on substr(ph.record_key,3,18) = sx6.serv_nbr
     and substr(sx6.serv_nbr,13,6) = '000100'
     and sx6.ymdrcvd > :pymdrcvd
     left outer join amiown.explain_code ec6
     on ec6.explain_x = substr(ph.free_form_data,16,4)
     and ec6.serv_pay_status = 'PEND'
--          and rownum < 100
)
select distinct
       cast(listagg(a.exc,',') within group (order by a.exc) as char(30)) explain_codes,
       cast(listagg(a.cdesc,',') within group (order by a.cdesc) as char(400)) explain_code_desc
from a
group by claim_nbr
) b
group by explain_codes, explain_code_desc;
