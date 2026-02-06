DO $$
DECLARE
	v text;
	r t_ci;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_ci;
		CREATE TYPE t_ci AS (a int, b text);
	$q$;

	r := ROW(1, 'a')::t_ci;
	v := r;

	EXECUTE 'DROP TYPE t_ci';
END;
$$;;
