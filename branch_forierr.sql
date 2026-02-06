DO $$
BEGIN
	BEGIN
		FOR i IN 1..3 BY 0 LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN invalid_parameter_value THEN
		NULL;
	END;
END;
$$;;
