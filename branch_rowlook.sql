DO $$
DECLARE
	r record;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_rl;
		CREATE TYPE t_rl AS (a int, b text);
	$q$;

	r := (SELECT ROW(1, 'x')::t_rl);

	EXECUTE 'DROP TYPE t_rl';
END;
$$;;
