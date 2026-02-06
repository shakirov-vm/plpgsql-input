DO $$
DECLARE
	r t_ma;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_ma;
		CREATE TYPE t_ma AS (a int, b int);
	$q$;

	PERFORM set_config('plpgsql.extra_errors', 'strict_multi_assignment', true);

	BEGIN
		SELECT 1 INTO r;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	PERFORM set_config('plpgsql.extra_errors', 'none', true);
	PERFORM set_config('plpgsql.extra_warnings', 'strict_multi_assignment', true);

	SELECT 1 INTO r;

	EXECUTE 'DROP TYPE t_ma';
END;
$$;;
