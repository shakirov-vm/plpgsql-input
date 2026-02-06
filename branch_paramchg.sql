DO $$
DECLARE
	r record;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_pf;
		CREATE TYPE t_pf AS (a int);
	$q$;

	r := ROW(1)::t_pf;
	EXECUTE 'SELECT $1' USING r.a;

	EXECUTE 'ALTER TYPE t_pf ADD ATTRIBUTE b int';

	BEGIN
		EXECUTE 'SELECT $1' USING r.a;
	EXCEPTION WHEN others THEN
		NULL;
	END;

	EXECUTE 'DROP TYPE t_pf';
END;
$$;;
