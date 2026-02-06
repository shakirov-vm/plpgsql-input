DO $$
BEGIN
	EXECUTE $q$
		DROP EVENT TRIGGER IF EXISTS evt_tg;
		DROP FUNCTION IF EXISTS evt_fn();
		CREATE FUNCTION evt_fn()
		RETURNS event_trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN;
		END;
		$fn$;
		CREATE EVENT TRIGGER evt_tg
		ON ddl_command_start
		EXECUTE FUNCTION evt_fn();
	$q$;

	EXECUTE 'CREATE TABLE evt_tbl(id int)';
	EXECUTE 'DROP TABLE evt_tbl';

	EXECUTE 'DROP EVENT TRIGGER evt_tg';
	EXECUTE 'DROP FUNCTION evt_fn()';
END;
$$;;
