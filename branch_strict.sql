DO $$
DECLARE
	v int;
BEGIN
	PERFORM set_config('plpgsql.print_strict_params', 'on', true);
	PERFORM set_config('plpgsql.extra_warnings', 'too_many_rows', true);

	BEGIN
		SELECT 1 INTO STRICT v WHERE false;
	EXCEPTION WHEN no_data_found THEN
		NULL;
	END;

	BEGIN
		SELECT 1 INTO STRICT v FROM (VALUES (1), (2)) s(x);
	EXCEPTION WHEN too_many_rows THEN
		NULL;
	END;

	SELECT 1 INTO v FROM (VALUES (1), (2)) s(x);
END;
$$;;
