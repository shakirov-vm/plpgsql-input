DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_pass_fn();
		DROP TABLE IF EXISTS trg_pass_tbl;
		CREATE TABLE trg_pass_tbl(id int, val text);
		CREATE FUNCTION trg_pass_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEW;
		END;
		$fn$;
		CREATE TRIGGER trg_pass
		BEFORE INSERT ON trg_pass_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_pass_fn();
	$q$;

	INSERT INTO trg_pass_tbl VALUES (1, 'a');

	EXECUTE 'DROP TRIGGER trg_pass ON trg_pass_tbl';
	EXECUTE 'DROP FUNCTION trg_pass_fn()';
	EXECUTE 'DROP TABLE trg_pass_tbl';
END;
$$;;
