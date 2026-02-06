DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_retvar();
		DROP FUNCTION IF EXISTS f_retexpr();
		DROP FUNCTION IF EXISTS f_retrec();
		DROP FUNCTION IF EXISTS f_retrow();
		DROP TYPE IF EXISTS t_ret;
		CREATE TYPE t_ret AS (a int, b text);
		CREATE FUNCTION f_retvar()
		RETURNS int
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v int := 7;
		BEGIN
			RETURN v;
		END;
		$fn$;
		CREATE FUNCTION f_retexpr()
		RETURNS int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN 1 + 2;
		END;
		$fn$;
		CREATE FUNCTION f_retrec()
		RETURNS t_ret
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			r record;
		BEGIN
			SELECT 10 AS a, 'hi' AS b INTO r;
			RETURN r;
		END;
		$fn$;
		CREATE FUNCTION f_retrow(OUT a int, OUT b int)
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			a := 1;
			b := 2;
			RETURN;
		END;
		$fn$;
	$q$;

	PERFORM f_retvar();
	PERFORM f_retexpr();
	PERFORM f_retrec();
	PERFORM * FROM f_retrow();

	EXECUTE 'DROP FUNCTION f_retrow()';
	EXECUTE 'DROP FUNCTION f_retrec()';
	EXECUTE 'DROP FUNCTION f_retexpr()';
	EXECUTE 'DROP FUNCTION f_retvar()';
	EXECUTE 'DROP TYPE t_ret';
END;
$$;;
