DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_del_fn();
		DROP TABLE IF EXISTS trg_del_tbl;
		CREATE TABLE trg_del_tbl(id int, val text);
		CREATE FUNCTION trg_del_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN OLD;
		END;
		$fn$;
		CREATE TRIGGER trg_del
		BEFORE DELETE ON trg_del_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_del_fn();
	$q$;

	INSERT INTO trg_del_tbl VALUES (1, 'a');
	DELETE FROM trg_del_tbl WHERE id = 1;

	EXECUTE 'DROP TRIGGER trg_del ON trg_del_tbl';
	EXECUTE 'DROP FUNCTION trg_del_fn()';
	EXECUTE 'DROP TABLE trg_del_tbl';
END;
$$;;
