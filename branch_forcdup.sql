DO $$
DECLARE
	c refcursor := 'dupcur';
	r record;
BEGIN
	OPEN c FOR SELECT 1 AS v;
	BEGIN
		FOR r IN c LOOP
			NULL;
		END LOOP;
	EXCEPTION WHEN duplicate_cursor THEN
		NULL;
	END;
	CLOSE c;
END;
$$;;
