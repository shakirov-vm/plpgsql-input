DO $$
DECLARE
	v int;
BEGIN
	PERFORM set_config('plpgsql.print_strict_params', 'on', true);
	BEGIN
		EXECUTE 'SELECT $1 UNION ALL SELECT $1' INTO STRICT v
		USING 1;
	EXCEPTION WHEN too_many_rows THEN
		NULL;
	END;
END;
$$;;
