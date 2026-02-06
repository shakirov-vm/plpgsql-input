DO $$
DECLARE
	c1 CURSOR (p int) FOR SELECT p AS v;
	c2 CURSOR FOR SELECT generate_series(1, 2) AS v;
	r record;
BEGIN
	FOR r IN c1(5) LOOP
		PERFORM r.v;
	END LOOP;

	FOR r IN c2 LOOP
		PERFORM r.v;
	END LOOP;
END;
$$;;
