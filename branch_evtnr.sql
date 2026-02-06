DO $$
BEGIN
	EXECUTE $q$
		DROP EVENT TRIGGER IF EXISTS evt_no_return;
		DROP FUNCTION IF EXISTS evt_no_return_fn();
		CREATE FUNCTION evt_no_return_fn()
		RETURNS event_trigger
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			/* no RETURN on purpose */
		END;
		$fn$;
		CREATE EVENT TRIGGER evt_no_return
		ON ddl_command_start
		EXECUTE FUNCTION evt_no_return_fn();
	$q$;

	EXECUTE 'CREATE TABLE evt_nr_tbl(id int)';
	EXECUTE 'DROP TABLE evt_nr_tbl';

	EXECUTE 'DROP EVENT TRIGGER evt_no_return';
	EXECUTE 'DROP FUNCTION evt_no_return_fn()';
END;
$$;;
