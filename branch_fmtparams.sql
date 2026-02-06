DO $$
DECLARE
	x int := 1;
	y text := 'abc';
	z text := NULL;
BEGIN
	PERFORM set_config('plpgsql.print_strict_params', 'on', true);

	BEGIN
		SELECT $1, $2, $3 INTO STRICT x
		FROM (VALUES (1), (2)) s(v)
		USING x, y, z;
	EXCEPTION WHEN too_many_rows THEN
		NULL;
	END;
END;
$$;;
