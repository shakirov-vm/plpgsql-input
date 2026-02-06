DO $$
BEGIN
	BEGIN
		FOR i IN 1..3 BY NULL LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN null_value_not_allowed THEN
		NULL;
	END;
END;
$$;;
