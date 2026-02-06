DO $$
BEGIN
	BEGIN
		RAISE EXCEPTION USING
			ERRCODE = '22012',
			MESSAGE = 'division by zero',
			DETAIL = 'detail text',
			HINT = 'hint text';
	EXCEPTION WHEN division_by_zero THEN
		NULL;
	END;
END;
$$;;
