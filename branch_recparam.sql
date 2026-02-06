DO $$
DECLARE
	r record;
BEGIN
	SELECT 1 AS a, 'x' AS b INTO r;
	EXECUTE 'SELECT $1' USING r;
END;
$$;;
