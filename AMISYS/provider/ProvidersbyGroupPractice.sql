-- This query lists group practices and providers with active affiliations
--    using the prac_nbr on the affiliation

select distinct gp.prac_nbr, gp.name_x, a.prov_nbr, p.lastname, p.firstname
from group_practice_m gp
inner join affiliation a
on gp.prac_nbr = a.prac_nbr
and void = ' '
and to_char(sysdate, 'yyyymmdd') between a.ymdeff and a.ymdend
inner join provider p
on a.prov_nbr = p.prov_nbr
order by gp.name_x, p.lastname;

-- This query lists group practices and providers with active affiliations
--    with the same NPI

select distinct gp.prac_nbr, gp.name_x, a.prov_nbr, p.lastname, p.firstname
from group_practice_m gp
inner join affiliation a
on gp.npi = a.npi
and void = ' '
and to_char(sysdate, 'yyyymmdd') between a.ymdeff and a.ymdend
inner join provider p
on a.prov_nbr = p.prov_nbr
order by gp.name_x, p.lastname;