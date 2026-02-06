DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rn_noset();
		DROP FUNCTION IF EXISTS f_rn_noncomp();
		DROP FUNCTION IF EXISTS f_rn_noexpr();
		DROP FUNCTION IF EXISTS f_rn_wrong();
		DROP TYPE IF EXISTS t_rnerr;
		CREATE TYPE t_rnerr AS (a int, b text);
		CREATE FUNCTION f_rn_noset()
		RETURNS int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT 1;
			RETURN 0;
		END;
		$fn$;
		CREATE FUNCTION f_rn_noncomp()
		RETURNS SETOF t_rnerr
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT 1;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_noexpr()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_wrong()
		RETURNS SETOF t_rnerr
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v int := 1;
		BEGIN
			RETURN NEXT v;
			RETURN;
		END;
		$fn$;
	$q$;

	BEGIN
		PERFORM f_rn_noset();
	EXCEPTION WHEN syntax_error THEN
		NULL;
	END;
	BEGIN
		PERFORM * FROM f_rn_noncomp();
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;
	BEGIN
		PERFORM * FROM f_rn_noexpr();
	EXCEPTION WHEN syntax_error THEN
		NULL;
	END;
	BEGIN
		PERFORM * FROM f_rn_wrong();
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	EXECUTE 'DROP FUNCTION f_rn_wrong()';
	EXECUTE 'DROP FUNCTION f_rn_noexpr()';
	EXECUTE 'DROP FUNCTION f_rn_noncomp()';
	EXECUTE 'DROP FUNCTION f_rn_noset()';
	EXECUTE 'DROP TYPE t_rnerr';
END;
$$;;
