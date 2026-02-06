DO $$
DECLARE
	r1 t_cmp1;
	r2 t_cmp2;
	r3 t_cmp3;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_cmp1;
		DROP TYPE IF EXISTS t_cmp2;
		DROP TYPE IF EXISTS t_cmp3;
		CREATE TYPE t_cmp1 AS (a int, b text);
		CREATE TYPE t_cmp2 AS (a int, b text);
		CREATE TYPE t_cmp3 AS (a int, b varchar(5));
	$q$;

	r1 := ROW(1, 'abc')::t_cmp1;
	r2 := r1;

	r3 := ROW(1, 'abc')::t_cmp3;
	BEGIN
		r2 := r3;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	EXECUTE 'DROP TYPE t_cmp3';
	EXECUTE 'DROP TYPE t_cmp2';
	EXECUTE 'DROP TYPE t_cmp1';
END;
$$;;
