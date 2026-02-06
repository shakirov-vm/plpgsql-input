DO $$
DECLARE
	r record;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_rf;
		CREATE TYPE t_rf AS (a int, b text);
	$q$;

	r := ROW(1, 'x')::t_rf;
	r.a := 2;

	EXECUTE 'DROP TYPE t_rf';
END;
$$;;
