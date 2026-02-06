DO $$
DECLARE
	v_ctx text;
BEGIN
	GET DIAGNOSTICS v_ctx = PG_CONTEXT;
END;
$$;;
