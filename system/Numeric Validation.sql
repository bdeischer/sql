-- Stored procedure to valid that the contents of a column is numeric
--  Returns 0 if column is not numeric

create or replace function is_numeric (
  p_strval in varchar2
  ) RETURN NUMBER
IS
  l_numval NUMBER;
BEGIN
  l_numval := TO_NUMBER(p_strval);
  RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
end is_numeric;
/
