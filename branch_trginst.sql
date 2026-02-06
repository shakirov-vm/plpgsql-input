DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS trg_instead_fn();
		DROP VIEW IF EXISTS trg_instead_v;
		DROP TABLE IF EXISTS trg_instead_t;
		CREATE TABLE trg_instead_t(id int, val text);
		CREATE VIEW trg_instead_v AS SELECT * FROM trg_instead_t;
		CREATE FUNCTION trg_instead_fn()
		RETURNS trigger
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v_when text;
		BEGIN
			v_when := TG_WHEN;
			INSERT INTO trg_instead_t VALUES (NEW.id, NEW.val);
			RETURN NEW;
		END;
		$fn$;
		CREATE TRIGGER trg_instead
		INSTEAD OF INSERT ON trg_instead_v
		FOR EACH ROW EXECUTE FUNCTION trg_instead_fn();
	$q$;

	INSERT INTO trg_instead_v VALUES (1, 'x');

	EXECUTE 'DROP TRIGGER trg_instead ON trg_instead_v';
	EXECUTE 'DROP FUNCTION trg_instead_fn()';
	EXECUTE 'DROP VIEW trg_instead_v';
	EXECUTE 'DROP TABLE trg_instead_t';
END;
$$;;
