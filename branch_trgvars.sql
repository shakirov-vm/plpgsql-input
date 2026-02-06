DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_vars_fn();
		DROP TABLE IF EXISTS trg_vars_tbl;
		CREATE TABLE trg_vars_tbl(id int, val text);
		CREATE FUNCTION trg_vars_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v_name text;
			v_when text;
			v_level text;
			v_op text;
			v_relid oid;
			v_tname name;
			v_tschema name;
			v_nargs int;
			v_argv text[];
		BEGIN
			v_name := TG_NAME;
			v_when := TG_WHEN;
			v_level := TG_LEVEL;
			v_op := TG_OP;
			v_relid := TG_RELID;
			v_tname := TG_TABLE_NAME;
			v_tschema := TG_TABLE_SCHEMA;
			v_nargs := TG_NARGS;
			v_argv := TG_ARGV;
			IF v_nargs > 0 THEN
				PERFORM v_argv[0];
			END IF;
			RETURN NEW;
		END;
		$fn$;
		CREATE TRIGGER trg_vars_ins
		BEFORE INSERT ON trg_vars_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_vars_fn('a1', 'b2');
		CREATE TRIGGER trg_vars_upd
		AFTER UPDATE ON trg_vars_tbl
		FOR EACH ROW EXECUTE FUNCTION trg_vars_fn();
		CREATE TRIGGER trg_vars_stmt
		AFTER INSERT ON trg_vars_tbl
		FOR EACH STATEMENT EXECUTE FUNCTION trg_vars_fn();
		CREATE TRIGGER trg_vars_trunc
		BEFORE TRUNCATE ON trg_vars_tbl
		FOR EACH STATEMENT EXECUTE FUNCTION trg_vars_fn();
	$q$;

	INSERT INTO trg_vars_tbl VALUES (1, 'a');
	UPDATE trg_vars_tbl SET val = 'b' WHERE id = 1;
	TRUNCATE trg_vars_tbl;

	EXECUTE 'DROP TRIGGER trg_vars_trunc ON trg_vars_tbl';
	EXECUTE 'DROP TRIGGER trg_vars_stmt ON trg_vars_tbl';
	EXECUTE 'DROP TRIGGER trg_vars_upd ON trg_vars_tbl';
	EXECUTE 'DROP TRIGGER trg_vars_ins ON trg_vars_tbl';
	EXECUTE 'DROP FUNCTION trg_vars_fn()';
	EXECUTE 'DROP TABLE trg_vars_tbl';
END;
$$;;
