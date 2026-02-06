DO $$
DECLARE
	arr int[] := ARRAY[]::int[];
	v int;
BEGIN
	FOREACH v IN ARRAY arr LOOP
		NULL;
	END LOOP;
END;
$$;;
