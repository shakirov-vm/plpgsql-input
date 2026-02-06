DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rq_noset();
		CREATE FUNCTION f_rq_noset()
		RETURNS int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN QUERY SELECT 1;
			RETURN 0;
		END;
		$fn$;
	$q$;

	BEGIN
		PERFORM f_rq_noset();
	EXCEPTION WHEN syntax_error THEN
		NULL;
	END;

	EXECUTE 'DROP FUNCTION f_rq_noset()';
END;
$$;;
