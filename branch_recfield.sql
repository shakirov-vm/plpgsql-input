DO $$
DECLARE
	r record;
	v int;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS rf_t;
		CREATE TYPE rf_t AS (a int, b text);
	$q$;

	-- instantiate record from named composite type
	r := NULL::rf_t;
	v := r.a;

	-- undefined field
	BEGIN
		v := r.c;
	EXCEPTION WHEN undefined_column THEN
		NULL;
	END;
END;
$$;;
