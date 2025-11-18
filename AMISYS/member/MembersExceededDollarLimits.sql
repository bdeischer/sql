with counter_limit
as
(
-- here
select
  bp.benefit_pkg,
  bp.description bp_description,
  cm.counter_x counter,
  cm.description ctr_description,
  case
    when cm.counter_x = substr(ckd.comp_keywords1,153,10)
      then substr(ckd.comp_keywords1,186,9)
    when cm.counter_x = substr(ckd.comp_keywords2,3,10)
      then substr(ckd.comp_keywords2,36,9)
    when cm.counter_x = substr(ckd.comp_keywords2,53,10)
      then substr(ckd.comp_keywords2,86,9)
    when cm.counter_x = substr(ckd.comp_keywords2,103,10)
      then substr(ckd.comp_keywords2,136,9)
    when cm.counter_x = substr(ckd.comp_keywords2,153,10)
      then substr(ckd.comp_keywords2,186,9)
    else
      '0'
  end ctr_limit,
  min(cks.ymdeff) limit_eff,
  max(cks.ymdend) limit_end
from
  comp_kywd_data ckd
  inner join comp_kywd_span cks
  on ckd.keyword_span_id = cks.keyword_span_id
  inner join benefit_pkg_m bp
  on cast(substr(ckd.comp_key,3,2) as char(2)) = bp.benefit_pkg
  inner join counter_m cm
  on cm.counter_x in (substr(ckd.comp_keywords1,153,10),
                      substr(ckd.comp_keywords2,3,10), 
                      substr(ckd.comp_keywords2,53,10), 
                      substr(ckd.comp_keywords2,103,10),
                      substr(ckd.comp_keywords2,153,10)
                     )
  inner join code_detail cd
  on cast('BD'||cm.bucket_def as char(6)) = cd.code_nbr
where
  substr(cd.description2,3,6) = 'DOLLAR'
group by
  bp.benefit_pkg,
  bp.description,
  cm.counter_x,
  cm.description,
  case
    when cm.counter_x = substr(ckd.comp_keywords1,153,10)
      then substr(ckd.comp_keywords1,186,9)
    when cm.counter_x = substr(ckd.comp_keywords2,3,10)
      then substr(ckd.comp_keywords2,36,9)
    when cm.counter_x = substr(ckd.comp_keywords2,53,10)
      then substr(ckd.comp_keywords2,86,9)
    when cm.counter_x = substr(ckd.comp_keywords2,103,10)
      then substr(ckd.comp_keywords2,136,9)
    when cm.counter_x = substr(ckd.comp_keywords2,153,10)
      then substr(ckd.comp_keywords2,186,9)
    else
      '0'
  end
order by 
  1, 3, 6
-- to here
)
select
  *
from
  (
  select
      ct.ymdplanyreff,
      ct.member_name,
      s.claim_nbr,
      s.ymdpaid,
      row_number() over (partition by ct.member_nbr, ct.ymdplanyreff order by s.ymdpaid desc) ymdpaid_rank,
      ct.division_nbr,
      ct.benefit_pkg,
      ct.counter_name,
      ct.member_nbr,
      ct.ymdmembereff,
      ct.ymdmemberend,
      ct.accum_amount,
      ct.limit_amount
  from
    (
    select
      rd.ymdplanyreff,
      rd.member_name,
      rd.division_nbr,
      rd.benefit_pkg,
      rd.counter_name,
      rd.member_nbr,
      min(rd.mymdeff) ymdmembereff,
      min(rd.mymdend) ymdmemberend,
      sum(rd.amount) accum_amount,
      rd.ctr_limit limit_amount
    from
      (
      select
        ms.member_nbr,
        rtrim(m.lastname)||', '||rtrim(m.firstname) member_name,
        ms.ymdeff mymdeff,
        ms.ymdend mymdend,
        ms.division_nbr,
        bpm.benefit_pkg,
        substr(cx.counter_key,1,10) counter_name,
        cx.amount,
        case
          when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
            then g.ymdanniv
          else
            substr(cx.ymddate,1,4) * 10000 + 0101
        end ymdplanyearbeg,
        to_char(add_months(to_date(case
          when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
            then g.ymdanniv
          else
            substr(cx.ymddate,1,4) * 10000 + 0101
        end,'YYYYMMDD')-1,12),'YYYYMMDD') ymdplanyearend,
        cx.ymddate,
        case
          when cx.ymddate 
            between 
              case
                when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
                  then g.ymdanniv
                else
                  substr(cx.ymddate,1,4) * 10000 + 0101
              end
              and
              to_char(add_months(to_date(case
                when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
                  then g.ymdanniv
                else
                  substr(cx.ymddate,1,4) * 10000 + 0101
              end,'YYYYMMDD')-1,12),'YYYYMMDD')
            then 
              case
                when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
                  then g.ymdanniv
                else
                  substr(cx.ymddate,1,4) * 10000 + 0101
              end
          when cx.ymddate 
            between 
              case
                when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
                  then to_number(to_char(add_months(to_date(g.ymdanniv,'YYYYMMDD'),12),'YYYYMMDD'),'00000000')
                else
                  (substr(cx.ymddate,1,4) + 1) * 10000 + 0101
              end
              and
              
              to_char(add_months(to_date(case
                when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
                  then to_number(to_char(add_months(to_date(g.ymdanniv,'YYYYMMDD'),12),'YYYYMMDD'),'00000000')
                else
                  (substr(cx.ymddate,1,4) + 1) * 10000 + 0101
              end,'YYYYMMDD')-1,24),'YYYYMMDD')
            then 
              case
                when bpm.anniv_ben_map = 'Y' and bpm.anniv_period = 'G'
                  then to_number(to_char(add_months(to_date(g.ymdanniv,'YYYYMMDD'),12),'YYYYMMDD'),'00000000')
                else
                  (substr(cx.ymddate,1,4) +1) * 10000 + 0101
              end
            else
              substr(cx.ymddate,1,4) * 10000 + 0101
          end ymdplanyreff,
          cl.ctr_limit
      from
        member_span ms
        inner join member m
        on ms.member_nbr = m.member_nbr
        inner join benefit_pkg_m bpm
        on ms.benefit_pkg = bpm.benefit_pkg
        inner join group_m g
        on ms.group_nbr = g.group_nbr
        inner join counter_x cx
        on ms.member_nbr = cx.who
        inner join counter_limit cl
        on bpm.benefit_pkg = cl.benefit_pkg
      where
        ms.void = '  '
        and cx.ymddate between ms.ymdeff and ms.ymdend
        and bpm.anniv_period <> '  '
        and cx.ymddate between cl.limit_eff and cl.limit_end
        and cx.status_x = ' '
        and substr(cx.counter_key,1,10) = cl.counter
      ) rd  
    group by
      rd.member_nbr,
      rd.member_name,
      rd.division_nbr,
      rd.benefit_pkg,
      rd.counter_name,
      rd.ymdplanyreff,
      rd.ctr_limit
    having
      sum(rd.amount) > min(rd.ctr_limit)
    order by
      1
    ) ct
    left outer join service_x s
    on ct.member_nbr = s.member_nbr
    and s.ymdeff between ct.ymdmembereff and ct.ymdmemberend
    and s.ymdpaid > 0
    and s.status_x like '1%'
    and s.amtcoins+s.amtcopay+s.amtdeduct <> 0
)
  where ymdpaid_rank = 1
;