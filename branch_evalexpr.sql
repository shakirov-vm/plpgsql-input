DO $$
DECLARE
	v int;
BEGIN
	v := (SELECT 1 WHERE false);

	BEGIN
		v := (SELECT 1, 2);
	EXCEPTION WHEN syntax_error THEN
		NULL;
	END;

	BEGIN
		v := (SELECT 1 UNION ALL SELECT 2);
	EXCEPTION WHEN cardinality_violation THEN
		NULL;
	END;
END;
$$;;
