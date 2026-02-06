DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rn_recnull();
		DROP TYPE IF EXISTS t_rnrecnull;
		CREATE TYPE t_rnrecnull AS (a int, b text);
		CREATE FUNCTION f_rn_recnull()
		RETURNS SETOF t_rnrecnull
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			r record;
		BEGIN
			RETURN NEXT r;
			RETURN;
		END;
		$fn$;
	$q$;

	PERFORM * FROM f_rn_recnull();

	EXECUTE 'DROP FUNCTION f_rn_recnull()';
	EXECUTE 'DROP TYPE t_rnrecnull';
END;
$$;;
