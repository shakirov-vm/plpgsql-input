DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_retbad();
		DROP TYPE IF EXISTS t_bad;
		CREATE TYPE t_bad AS (a int, b text);
		CREATE FUNCTION f_retbad()
		RETURNS t_bad
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v int := 1;
		BEGIN
			RETURN v;
		END;
		$fn$;
	$q$;

	BEGIN
		PERFORM f_retbad();
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	EXECUTE 'DROP FUNCTION f_retbad()';
	EXECUTE 'DROP TYPE t_bad';
END;
$$;;
