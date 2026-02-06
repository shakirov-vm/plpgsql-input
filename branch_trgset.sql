DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_set_fn();
		DROP TABLE IF EXISTS trg_set_tbl;
		CREATE TABLE trg_set_tbl(id int);
		CREATE FUNCTION trg_set_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEXT NEW;
			RETURN NEW;
		END;
		$fn$;
		CREATE TRIGGER trg_set
		BEFORE INSERT ON trg_set_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_set_fn();
	$q$;

	INSERT INTO trg_set_tbl VALUES (1);

	EXECUTE 'DROP TRIGGER trg_set ON trg_set_tbl';
	EXECUTE 'DROP FUNCTION trg_set_fn()';
	EXECUTE 'DROP TABLE trg_set_tbl';
END;
$$;;
