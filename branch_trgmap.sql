DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_map_fn();
		DROP TABLE IF EXISTS trg_map_tbl;
		CREATE TABLE trg_map_tbl(id int, val text);
		CREATE FUNCTION trg_map_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			r record;
		BEGIN
			SELECT NEW.val AS val, NEW.id AS id INTO r;
			RETURN r;
		END;
		$fn$;
		CREATE TRIGGER trg_map
		BEFORE UPDATE ON trg_map_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_map_fn();
	$q$;

	INSERT INTO trg_map_tbl VALUES (1, 'a');
	UPDATE trg_map_tbl SET val = 'b' WHERE id = 1;

	EXECUTE 'DROP TRIGGER trg_map ON trg_map_tbl';
	EXECUTE 'DROP FUNCTION trg_map_fn()';
	EXECUTE 'DROP TABLE trg_map_tbl';
END;
$$;;
