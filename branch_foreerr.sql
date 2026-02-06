DO $$
DECLARE
	arr int[] := ARRAY[1, 2];
	v int;
	v_arr int[];
BEGIN
	BEGIN
		FOREACH v IN ARRAY NULL::int[] LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN null_value_not_allowed THEN
		NULL;
	END;

	BEGIN
		FOREACH v IN ARRAY 1 LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	BEGIN
		FOREACH v SLICE 2 IN ARRAY arr LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN array_subscript_error THEN
		NULL;
	END;

	BEGIN
		FOREACH v SLICE 1 IN ARRAY arr LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	BEGIN
		FOREACH v_arr IN ARRAY arr LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;
END;
$$;;
