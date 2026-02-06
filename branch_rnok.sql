DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_rn_var();
		DROP FUNCTION IF EXISTS f_rn_rec();
		DROP FUNCTION IF EXISTS f_rn_row();
		DROP FUNCTION IF EXISTS f_rn_expr();
		DROP FUNCTION IF EXISTS f_rn_comp();
		DROP FUNCTION IF EXISTS f_rn_null();
		DROP TYPE IF EXISTS t_rn;
		CREATE TYPE t_rn AS (a int, b text);
		CREATE FUNCTION f_rn_var()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v int := 5;
		BEGIN
			RETURN NEXT v;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_rec()
		RETURNS SETOF t_rn
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			r t_rn;
		BEGIN
			r := ROW(1, 'a')::t_rn;
			RETURN NEXT r;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_row(OUT a int, OUT b int)
		RETURNS SETOF record
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			a := 1;
			b := 2;
			RETURN NEXT;
			a := 3;
			b := 4;
			RETURN NEXT;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_expr()
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT 7;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_comp()
		RETURNS SETOF t_rn
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT ROW(2, 'b')::t_rn;
			RETURN;
		END;
		$fn$;
		CREATE FUNCTION f_rn_null()
		RETURNS SETOF t_rn
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT NULL;
			RETURN;
		END;
		$fn$;
	$q$;

	PERFORM * FROM f_rn_var();
	PERFORM * FROM f_rn_rec();
	PERFORM * FROM f_rn_row();
	PERFORM * FROM f_rn_expr();
	PERFORM * FROM f_rn_comp();
	PERFORM * FROM f_rn_null();

	EXECUTE 'DROP FUNCTION f_rn_null()';
	EXECUTE 'DROP FUNCTION f_rn_comp()';
	EXECUTE 'DROP FUNCTION f_rn_expr()';
	EXECUTE 'DROP FUNCTION f_rn_row()';
	EXECUTE 'DROP FUNCTION f_rn_rec()';
	EXECUTE 'DROP FUNCTION f_rn_var()';
	EXECUTE 'DROP TYPE t_rn';
END;
$$;;
