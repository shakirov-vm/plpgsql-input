DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_replan();
		DROP FUNCTION IF EXISTS f_wrap();
		CREATE FUNCTION f_replan()
		RETURNS int
		LANGUAGE sql
		AS $fn$
			SELECT 1;
		$fn$;
		CREATE FUNCTION f_wrap()
		RETURNS void
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v int;
		BEGIN
			v := f_replan();
			EXECUTE $q2$
				CREATE OR REPLACE FUNCTION f_replan()
				RETURNS SETOF int
				LANGUAGE sql
				AS $$ SELECT 1 UNION ALL SELECT 2 $$;
			$q2$;
			BEGIN
				v := f_replan();
			EXCEPTION WHEN others THEN
				NULL;
			END;
		END;
		$fn$;
	$q$;

	PERFORM f_wrap();

	EXECUTE 'DROP FUNCTION f_wrap()';
	EXECUTE 'DROP FUNCTION f_replan()';
END;
$$;;
