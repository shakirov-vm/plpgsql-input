DO $$
BEGIN
	PERFORM 1;
	PERFORM generate_series(1, 3);
END;
$$;;
