DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rq_err();
		CREATE FUNCTION f_rq_err()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN QUERY SELECT 1 AS a, 2 AS b;
			RETURN;
		END;
		$fn$;
	$q$;

	BEGIN
		PERFORM * FROM f_rq_err();
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	EXECUTE 'DROP FUNCTION f_rq_err()';
END;
$$;;
