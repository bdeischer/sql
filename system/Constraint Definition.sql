-- List the constraint definition (table/column) using constraint name as input
-- Change 'CONSTRAINT_NAME'

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

