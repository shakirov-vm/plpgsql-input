DO $$
BEGIN
	EXECUTE $q$
		DROP PROCEDURE IF EXISTS p_out_err(OUT x int);
		CREATE PROCEDURE p_out_err(OUT x int)
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			x := 1;
		END;
		$fn$;
	$q$;

	BEGIN
		CALL p_out_err(1);
	EXCEPTION WHEN others THEN
		NULL;
	END;

	EXECUTE 'DROP PROCEDURE p_out_err(OUT x int)';
END;
$$;;
