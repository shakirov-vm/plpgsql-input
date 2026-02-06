DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rq_static();
		DROP FUNCTION IF EXISTS f_rq_dyn();
		CREATE FUNCTION f_rq_static()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN QUERY SELECT generate_series(1, 3);
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rq_dyn()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN QUERY EXECUTE 'SELECT generate_series(4, 5)';
			RETURN;
		END;
		$fn$;
	$q$;

	PERFORM * FROM f_rq_static();
	PERFORM * FROM f_rq_dyn();

	EXECUTE 'DROP FUNCTION f_rq_dyn()';
	EXECUTE 'DROP FUNCTION f_rq_static()';
END;
$$;;
