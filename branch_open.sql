DO $$
DECLARE
	c1 refcursor;
	c2 CURSOR FOR SELECT 1 AS a;
	c3 CURSOR (p int) FOR SELECT p AS a;
	v int;
BEGIN
	/* OPEN refcursor FOR SELECT ... */
	OPEN c1 FOR SELECT 1;
	CLOSE c1;

	/* OPEN refcursor FOR EXECUTE ... */
	OPEN c1 FOR EXECUTE 'SELECT 2';
	CLOSE c1;

	/* OPEN cursor with args */
	OPEN c3(7);
	CLOSE c3;

	/* OPEN cursor without args */
	OPEN c2;
	CLOSE c2;
END;
$$;;
