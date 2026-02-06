DO $$
BEGIN
	EXECUTE $q$
		DROP EVENT TRIGGER IF EXISTS evt_vars;
		DROP FUNCTION IF EXISTS evt_vars_fn();
		CREATE FUNCTION evt_vars_fn()
		RETURNS event_trigger
		LANGUAGE plpgsql
		AS $fn$
		DECLARE
			v_event text;
			v_tag text;
		BEGIN
			v_event := TG_EVENT;
			v_tag := TG_TAG;
			RETURN;
		END;
		$fn$;
		CREATE EVENT TRIGGER evt_vars
		ON ddl_command_start
		EXECUTE FUNCTION evt_vars_fn();
	$q$;

	EXECUTE 'CREATE TABLE evt_vars_tbl(id int)';
	EXECUTE 'DROP TABLE evt_vars_tbl';

	EXECUTE 'DROP EVENT TRIGGER evt_vars';
	EXECUTE 'DROP FUNCTION evt_vars_fn()';
END;
$$;;
