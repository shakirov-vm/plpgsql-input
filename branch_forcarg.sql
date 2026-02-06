DO $$
DECLARE
	c1 CURSOR (p int) FOR SELECT p AS v;
	r record;
BEGIN
	BEGIN
		FOR r IN c1 LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN syntax_error THEN
		NULL;
	END;
END;
$$;;
