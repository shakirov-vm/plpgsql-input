DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_compdom();
		DROP DOMAIN IF EXISTS d_comp;
		DROP TYPE IF EXISTS t_comp;
		CREATE TYPE t_comp AS (a int, b text);
		CREATE DOMAIN d_comp AS t_comp;
		CREATE FUNCTION f_compdom()
		RETURNS d_comp
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN ROW(7, 'dom')::t_comp;
		END;
		$fn$;
	$q$;

	PERFORM f_compdom();

	EXECUTE 'DROP FUNCTION f_compdom()';
	EXECUTE 'DROP DOMAIN d_comp';
	EXECUTE 'DROP TYPE t_comp';
END;
$$;;
