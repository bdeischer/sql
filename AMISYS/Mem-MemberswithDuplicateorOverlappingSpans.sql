with mdups
as
(
select
  m.member_nbr,
  m.image_recnbr,
  m.ymdeff,
  m.ymdend,
  m.ymdtrans,
  m.op_nbr,
  m2.image_recnbr image_recnbr_dup,
  m2.ymdeff ymdeff_dup,
  m2.ymdend ymdend_dup,
  m2.ymdtrans ymdtrans_dup,
  m2.op_nbr op_nbr_dup
from
  exeter.member_span m
  inner join exeter.member_span m2
  on m.member_nbr = m2.member_nbr
where
  m.image_recnbr < m2.image_recnbr
  and m.void = '  '
  and m2.void = '  '
  and (m.ymdeff between m2.ymdeff and m2.ymdend or m2.ymdeff between m.ymdeff and m.ymdend)
order by
  m.member_nbr,
  m.image_recnbr,
  m2.image_recnbr
)
--select member_nbr, count(*) dups from (          -- Uncomment to count dups rather than list them
select
  md.*
from
  mdups md
  inner join
    (
    select
      min(image_recnbr) image_recnbr
    from
      mdups
    group by
      member_nbr
    ) mdmin
  on md.image_recnbr = mdmin.image_recnbr
--) group by member_nbr order by 2 desc          -- Uncomment to count dups rather than list them
;