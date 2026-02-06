DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_stmt_fn();
		DROP TABLE IF EXISTS trg_stmt_tbl;
		CREATE TABLE trg_stmt_tbl(id int, val text);
		CREATE FUNCTION trg_stmt_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NULL;
		END;
		$fn$;
		CREATE TRIGGER trg_stmt
		AFTER INSERT ON trg_stmt_tbl
		FOR EACH STATEMENT EXECUTE FUNCTION trg_stmt_fn();
	$q$;

	INSERT INTO trg_stmt_tbl VALUES (1, 'a');

	EXECUTE 'DROP TRIGGER trg_stmt ON trg_stmt_tbl';
	EXECUTE 'DROP FUNCTION trg_stmt_fn()';
	EXECUTE 'DROP TABLE trg_stmt_tbl';
END;
$$;;
