-- List of constraints for a specific table

select
    substr(CONS.CONSTRAINT_NAME,1,20) constraint_name,
    substr(CONS.TABLE_NAME,1,20) table_name,
    substr(COLS.COLUMN_NAME,1,20) column_name,
    substr(CONS.R_CONSTRAINT_NAME,1,20) r_constraint_name,
    substr(CONS_R.TABLE_NAME,1,20) r_table_name,
    substr(COLS_R.COLUMN_NAME,1,20) r_column_name
from ALL_CONSTRAINTS CONS
left join all_CONS_COLUMNS COLS ON COLS.CONSTRAINT_NAME = CONS.CONSTRAINT_NAME
left join all_CONSTRAINTS CONS_R ON CONS_R.CONSTRAINT_NAME = CONS.R_CONSTRAINT_NAME
left join all_CONS_COLUMNS COLS_R ON COLS_R.CONSTRAINT_NAME = CONS.R_CONSTRAINT_NAME
where CONS.CONSTRAINT_TYPE = 'R'
 and cons.table_name = 'TABLE_NAME'
order by CONS.TABLE_NAME, COLS.COLUMN_NAME;

-- List the constraint definition (table/column) using constraint name as input

select a.table_name, 
       a. column_name, 
       a.constraint_name, 
       c.owner,
       c.r_owner, 
       c_pk.table_name r_table_name, 
       c_pk.constraint_name r_pk
   from all_cons_columns a
   join all_constraints c
   on a.owner = c.owner
   and a.constraint_name = c.constraint_name
   join all_constraints c_pk 
   on c.r_owner = c_pk.owner
   and c.r_constraint_name = c_pk.constraint_name
   where a.constraint_name = 'CONSTRAINT_NAME';