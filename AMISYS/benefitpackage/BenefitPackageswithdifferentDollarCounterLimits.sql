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
--select * from counter_limit;
select
  cl.benefit_pkg,
  cl.bp_description,
  cl.counter,
  cl.ctr_description,
  cl.ctr_limit,
  cl.limit_eff,
  cl.limit_end,
  cl2.ctr_limit ctr_limit_2,
  cl2.limit_eff limit_eff_2,
  cl2.limit_end limit_end_2
from
  counter_limit cl
  inner join counter_limit cl2
  on cl.benefit_pkg = cl2.benefit_pkg
where
  cl.counter = cl2.counter
  and cl.ctr_limit < cl2.ctr_limit
  and (cl.limit_eff between cl2.limit_eff and cl2.limit_end or cl2.limit_eff between cl.limit_eff and cl.limit_end)
--  and cl.counter not like '%HEAR%'
;