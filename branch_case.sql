DO $$
DECLARE
	x int;
	y int;
BEGIN
	x := 2;
	CASE x
		WHEN 1 THEN
			y := 10;
		WHEN 2 THEN
			y := 20;
		ELSE
			y := 30;
	END CASE;

	CASE
		WHEN false THEN
			y := 1;
		ELSE
			y := 2;
	END CASE;
END;
$$;;
