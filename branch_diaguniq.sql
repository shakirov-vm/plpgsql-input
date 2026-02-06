DO $$
DECLARE
	v_sqlstate text;
	v_message text;
	v_detail text;
	v_hint text;
	v_column text;
	v_constraint text;
	v_table text;
	v_schema text;
BEGIN
	EXECUTE $q$
		CREATE SCHEMA IF NOT EXISTS diag_s;
		DROP TABLE IF EXISTS diag_s.t;
		CREATE TABLE diag_s.t(
			id int NOT NULL,
			val text,
			UNIQUE (id)
		);
	$q$;

	BEGIN
		INSERT INTO diag_s.t(id, val) VALUES (1, 'a');
		INSERT INTO diag_s.t(id, val) VALUES (1, 'b');
	EXCEPTION WHEN unique_violation THEN
		GET STACKED DIAGNOSTICS
			v_sqlstate = RETURNED_SQLSTATE,
			v_message = MESSAGE_TEXT,
			v_detail = PG_EXCEPTION_DETAIL,
			v_hint = PG_EXCEPTION_HINT,
			v_column = COLUMN_NAME,
			v_constraint = CONSTRAINT_NAME,
			v_table = TABLE_NAME,
			v_schema = SCHEMA_NAME;
	END;

	EXECUTE 'DROP TABLE diag_s.t';
	EXECUTE 'DROP SCHEMA diag_s';
END;
$$;;
