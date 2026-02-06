DO $$
DECLARE
	r record;
	v int;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS rt_t;
		CREATE TYPE rt_t AS (a int, b text);
	$q$;

	r := NULL::rt_t;
	v := r.a;
END;
$$;;
