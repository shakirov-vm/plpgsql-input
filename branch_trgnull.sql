DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_null_fn();
		DROP TABLE IF EXISTS trg_null_tbl;
		CREATE TABLE trg_null_tbl(id int, val text);
		CREATE FUNCTION trg_null_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NULL;
		END;
		$fn$;
		CREATE TRIGGER trg_null
		BEFORE INSERT ON trg_null_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_null_fn();
	$q$;

	INSERT INTO trg_null_tbl VALUES (1, 'a');

	EXECUTE 'DROP TRIGGER trg_null ON trg_null_tbl';
	EXECUTE 'DROP FUNCTION trg_null_fn()';
	EXECUTE 'DROP TABLE trg_null_tbl';
END;
$$;;
