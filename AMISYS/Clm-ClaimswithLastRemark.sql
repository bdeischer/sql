select distinct c.claim_nbr,
                s.serv_nbr,
                c.claim_type,
                i.ymddue as date_processed,
                ses.ses_name,
                ses.op_nbr as opid,
                ses.firstname||ses.lastname as OPID_name,
                c.resolution,
                s.ex_array,
                case
                  when max(substr(s.serv_nbr,15,2)) <> '00' then 'Adjustment'
                  else 'New day claim'
                end work_type,
                rs1.remark as last_remark
    from claim c
    inner join service_x s on c.claim_nbr = s.claim_nbr
    inner join in_process i on c.claim_nbr = i.claim_nbr
    inner join ses_data ses on s.op_nbr = ses.op_nbr
    left outer join
      (select remark_cat,max(ymdtrans) ymdtrans_max
         from remark_summary
         group by remark_cat) rs
      on c.claim_nbr = substr(rs.remark_cat,1,12)
    left outer join remark_summary rs1 on c.claim_nbr = substr(rs1.remark_cat,1,12) and rs.ymdtrans_max = rs1.ymdtrans
      where i.ymddue between 20250921 and 20250930
        and s.ymdpaid  > 0
        group by c.claim_nbr,s.serv_nbr,c.claim_type,i.ymddue,ses.ses_name,
                 ses.op_nbr,ses.firstname,ses.lastname,c.resolution,s.ex_array,rs1.remark_cat,rs1.remark
        order by s.serv_nbr;