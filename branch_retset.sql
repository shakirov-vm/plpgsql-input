DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_set(int);
		CREATE FUNCTION f_set(n int)
		RETURNS SETOF int
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			i int;
		BEGIN
			FOR i IN 1..n LOOP
				RETURN NEXT i;
			END LOOP;
			RETURN;
		END;
		$fn$;
	$q$;

	PERFORM * FROM f_set(3);

	EXECUTE 'DROP FUNCTION f_set(int)';
END;
$$;;
