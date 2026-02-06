DO $$
DECLARE
	r record;
	r2 record;
	v int;
BEGIN
	EXECUTE $q$
		DROP TABLE IF EXISTS rv_t;
		CREATE TABLE rv_t(a int, b text);
	$q$;

	-- rec->erh NULL path
	v := r;

	-- rec->erh non-empty, declared RECORD path
	SELECT a, b INTO r2 FROM rv_t LIMIT 0;
	v := r2;
END;
$$;;
