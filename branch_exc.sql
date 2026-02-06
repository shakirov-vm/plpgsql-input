DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_exmatch();
		DROP FUNCTION IF EXISTS f_retcopy();
		CREATE FUNCTION f_exmatch()
		RETURNS void
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			BEGIN
				RAISE EXCEPTION USING ERRCODE = '23505';
			EXCEPTION WHEN unique_violation THEN
				NULL;
			END;
			BEGIN
				RAISE EXCEPTION USING ERRCODE = '23503';
			EXCEPTION WHEN integrity_constraint_violation THEN
				NULL;
			END;
		END;
		$fn$;
		CREATE FUNCTION f_retcopy()
		RETURNS int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			BEGIN
				RETURN 42;
			EXCEPTION WHEN OTHERS THEN
				RETURN 0;
			END;
		END;
		$fn$;
	$q$;

	PERFORM f_exmatch();
	PERFORM f_retcopy();

	EXECUTE 'DROP FUNCTION f_retcopy()';
	EXECUTE 'DROP FUNCTION f_exmatch()';
END;
$$;;
