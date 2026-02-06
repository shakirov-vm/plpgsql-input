DO $$
DECLARE
	x int := 1;
	y text := 'str';
	z text := NULL;
BEGIN
	EXECUTE 'SELECT $1::int, $2::text, $3'
	USING x, y, z;

	EXECUTE 'SELECT $1'
	USING 'unknown';
END;
$$;;
