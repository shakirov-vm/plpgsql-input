DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rn_map();
		DROP TYPE IF EXISTS t_rnmap;
		CREATE TYPE t_rnmap AS (a int, b text);
		CREATE FUNCTION f_rn_map()
		RETURNS SETOF t_rnmap
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT ROW('x'::text, 1)::record;
			RETURN;
		END;
		$fn$;
	$q$;

	PERFORM * FROM f_rn_map();

	EXECUTE 'DROP FUNCTION f_rn_map()';
	EXECUTE 'DROP TYPE t_rnmap';
END;
$$;;
