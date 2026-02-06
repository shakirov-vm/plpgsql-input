DO $$
DECLARE
	arr int[] := ARRAY[1, 2, 3];
	v int;
	vslice int[];
BEGIN
	FOREACH v IN ARRAY arr LOOP
		NULL;
	END LOOP;

	FOREACH vslice SLICE 1 IN ARRAY arr LOOP
		NULL;
	END LOOP;
END;
$$;;
