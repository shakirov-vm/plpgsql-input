DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rq_null();
		CREATE FUNCTION f_rq_null()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN QUERY EXECUTE NULL;
			RETURN;
		END;
		$fn$;
	$q$;

	BEGIN
		PERFORM * FROM f_rq_null();
	EXCEPTION WHEN null_value_not_allowed THEN
		NULL;
	END;

	EXECUTE 'DROP FUNCTION f_rq_null()';
END;
$$;;
