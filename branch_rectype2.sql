DO $$
DECLARE
	r record;
	v int;
BEGIN
	EXECUTE $q$
		DROP TABLE IF EXISTS rt2_t;
		CREATE TABLE rt2_t(a int, b text);
	$q$;

	SELECT a, b INTO r FROM rt2_t LIMIT 0;
	v := r.a;
END;
$$;;
