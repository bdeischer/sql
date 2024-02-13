-- Report the foreign keys for a given table.  Replace TABLENAME with table name

var v_tablename char(30);

exec :v_tablename := 'TABLENAME';

select distinct
  cast(trim(table_name
  ||','||
  nvl((
  select distinct
    trim(a.column_name) column_name
  from 
    all_cons_columns a
    join all_constraints c 
    on a.owner = c.owner
    and a.constraint_name = c.constraint_name
    join all_constraints c_pk 
    on c.r_owner = c_pk.owner
    and c.r_constraint_name = c_pk.constraint_name
  where c.constraint_type = 'R'
    and c_pk.table_name in (:v_tablename)
  ),'NOFK')) as char(60)) table_name,
  column_name,
  column_id
from 
  all_tab_columns 
where 
  table_name =:v_tablename
  and column_name not in ('IMAGE_RECNBR','CHECKSUM_VALUE')
order by
  column_id
;
