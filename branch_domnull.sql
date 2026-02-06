DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_dom_null();
		DROP DOMAIN IF EXISTS d_int;
		CREATE DOMAIN d_int AS int CHECK (VALUE > 0);
		CREATE FUNCTION f_dom_null()
		RETURNS d_int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NULL;
		END;
		$fn$;
	$q$;

	PERFORM f_dom_null();

	EXECUTE 'DROP FUNCTION f_dom_null()';
	EXECUTE 'DROP DOMAIN d_int';
END;
$$;;
