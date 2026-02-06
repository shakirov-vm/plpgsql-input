DO $$
DECLARE
	r t_ma2;
BEGIN
	EXECUTE $q$
		DROP TYPE IF EXISTS t_ma2;
		CREATE TYPE t_ma2 AS (a int, b int);
	$q$;

	PERFORM set_config('plpgsql.extra_errors', 'strict_multi_assignment', true);

	BEGIN
		SELECT 1, 2, 3 INTO r;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	PERFORM set_config('plpgsql.extra_errors', 'none', true);
	PERFORM set_config('plpgsql.extra_warnings', 'strict_multi_assignment', true);

	SELECT 1, 2, 3 INTO r;

	EXECUTE 'DROP TYPE t_ma2';
END;
$$;;
