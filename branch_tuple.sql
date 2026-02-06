DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_tuple();
		DROP TYPE IF EXISTS t_order;
		CREATE TYPE t_order AS (a int, b text);
		CREATE FUNCTION f_tuple()
		RETURNS t_order
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			r record;
		BEGIN
			SELECT 10 AS a, 'hi' AS b INTO r;
			RETURN r;
		END;
		$fn$;
	$q$;

	PERFORM f_tuple();

	EXECUTE 'DROP FUNCTION f_tuple()';
	EXECUTE 'DROP TYPE t_order';
END;
$$;;
