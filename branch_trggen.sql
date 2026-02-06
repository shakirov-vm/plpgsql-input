DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_gen_fn();
		DROP TABLE IF EXISTS trg_gen_tbl;
		CREATE TABLE trg_gen_tbl(
			a int,
			b int GENERATED ALWAYS AS (a + 1) STORED,
			val text
		);
		CREATE FUNCTION trg_gen_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN NEW;
		END;
		$fn$;
		CREATE TRIGGER trg_gen
		BEFORE UPDATE ON trg_gen_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_gen_fn();
	$q$;

	INSERT INTO trg_gen_tbl(a, val) VALUES (1, 'x');
	UPDATE trg_gen_tbl SET a = 2 WHERE a = 1;

	EXECUTE 'DROP TRIGGER trg_gen ON trg_gen_tbl';
	EXECUTE 'DROP FUNCTION trg_gen_fn()';
	EXECUTE 'DROP TABLE trg_gen_tbl';
END;
$$;;
