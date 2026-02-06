# option dump
DO $$
DECLARE
	v_cnt bigint;
	v_ctx text;
	v_sqlstate text;
	v_message text;
	v_detail text;
	v_hint text;
	v_column text;
	v_constraint text;
	v_dtype text;
	v_table text;
	v_schema text;
	v_exctx text;
BEGIN
	PERFORM 1;
	GET DIAGNOSTICS v_cnt = ROW_COUNT, v_ctx = PG_CONTEXT;
	BEGIN
		RAISE EXCEPTION 'boom';
	EXCEPTION WHEN others THEN
		GET STACKED DIAGNOSTICS
			v_exctx = PG_EXCEPTION_CONTEXT,
			v_detail = PG_EXCEPTION_DETAIL,
			v_hint = PG_EXCEPTION_HINT,
			v_sqlstate = RETURNED_SQLSTATE,
			v_column = COLUMN_NAME,
			v_constraint = CONSTRAINT_NAME,
			v_dtype = PG_DATATYPE_NAME,
			v_message = MESSAGE_TEXT,
			v_table = TABLE_NAME,
			v_schema = SCHEMA_NAME;
	END;
END;
$$;;
