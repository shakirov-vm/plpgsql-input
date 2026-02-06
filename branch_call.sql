DO $$
BEGIN
	EXECUTE $q$
		DROP PROCEDURE IF EXISTS p_out(INOUT x int, OUT y int);
		CREATE PROCEDURE p_out(INOUT x int, OUT y int)
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			x := x + 1;
			y := x * 2;
		END;
		$fn$;
	$q$;

	DO $inner$
	DECLARE
		a int := 10;
		b int;
	BEGIN
		CALL p_out(a, b);
	END;
	$inner$;

	EXECUTE 'DROP PROCEDURE p_out(INOUT x int, OUT y int)';
END;
$$;;
