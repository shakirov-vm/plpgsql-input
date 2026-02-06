DO $$
DECLARE
	r record;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_rs;
		CREATE TYPE t_rs AS (a int, b text);
	$q$;

	r := ROW(1, 'a')::t_rs;
	r := ROW(2, 'b')::t_rs;

	EXECUTE 'DROP TYPE t_rs';
END;
$$;;
