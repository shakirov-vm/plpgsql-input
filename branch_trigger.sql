DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_fn();
		DROP TABLE IF EXISTS trg_tbl;
		CREATE TABLE trg_tbl(id int, val text);
		CREATE FUNCTION trg_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			IF TG_OP = 'INSERT' THEN
				NEW.val := NEW.val || '_i';
				RETURN NEW;
			ELSIF TG_OP = 'UPDATE' THEN
				NEW.val := NEW.val || '_u';
				RETURN NEW;
			ELSIF TG_OP = 'DELETE' THEN
				RETURN OLD;
			END IF;
			RETURN NULL;
		END;
		$fn$;
		CREATE TRIGGER trg_tbl_biud
		BEFORE INSERT OR UPDATE OR DELETE ON trg_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_fn();
	$q$;

	INSERT INTO trg_tbl VALUES (1, 'a');
	UPDATE trg_tbl SET val = 'b' WHERE id = 1;
	DELETE FROM trg_tbl WHERE id = 1;

	EXECUTE 'DROP TRIGGER trg_tbl_biud ON trg_tbl';
	EXECUTE 'DROP FUNCTION trg_fn()';
	EXECUTE 'DROP TABLE trg_tbl';
END;
$$;;
