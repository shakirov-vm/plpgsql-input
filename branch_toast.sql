DO $$
DECLARE
	v text;
BEGIN
	v := repeat('x', 100000);
	v := repeat('y', 100000);
END;
$$;;
