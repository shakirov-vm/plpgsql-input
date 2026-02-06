DO $$
DECLARE
	r record;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_ra;
		CREATE TYPE t_ra AS (a int, b text);
	$q$;

	r := ROW(1, 'a')::t_ra;
	r := r;

	r := NULL::t_ra;

	EXECUTE 'DROP TYPE t_ra';
END;
$$;;
