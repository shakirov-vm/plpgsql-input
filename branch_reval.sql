DO $$
DECLARE
	r t_reval;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_reval;
		CREATE TYPE t_reval AS (a int);
	$q$;

	r := ROW(1)::t_reval;

	EXECUTE 'ALTER TYPE t_reval ADD ATTRIBUTE b int';

	r := ROW(1, 2)::t_reval;
	PERFORM r.b;

	EXECUTE 'DROP TYPE t_reval';
END;
$$;;
