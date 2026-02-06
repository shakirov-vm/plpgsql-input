DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_ret_rec();
		DROP FUNCTION IF EXISTS trg_ret_row();
		DROP TABLE IF EXISTS trg_ret_tbl;
		CREATE TABLE trg_ret_tbl(id int, val text);
		CREATE FUNCTION trg_ret_rec()
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
		CREATE FUNCTION trg_ret_row()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN (SELECT ROW(NEW.id, NEW.val));
		END;
		$fn$;
		CREATE TRIGGER trg_ret_rec_t
		BEFORE UPDATE ON trg_ret_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_ret_rec();
		CREATE TRIGGER trg_ret_row_t
		BEFORE UPDATE ON trg_ret_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_ret_row();
	$q$;

	INSERT INTO trg_ret_tbl VALUES (1, 'a');
	UPDATE trg_ret_tbl SET val = 'b' WHERE id = 1;

	EXECUTE 'DROP TRIGGER trg_ret_row_t ON trg_ret_tbl';
	EXECUTE 'DROP TRIGGER trg_ret_rec_t ON trg_ret_tbl';
	EXECUTE 'DROP FUNCTION trg_ret_row()';
	EXECUTE 'DROP FUNCTION trg_ret_rec()';
	EXECUTE 'DROP TABLE trg_ret_tbl';
END;
$$;;
