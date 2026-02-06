DO $$
DECLARE
	v_datatype text;
	v_message text;
BEGIN
	BEGIN
		PERFORM 'not_a_number'::int;
	EXCEPTION WHEN invalid_text_representation THEN
		GET STACKED DIAGNOSTICS
			v_datatype = PG_DATATYPE_NAME,
			v_message = MESSAGE_TEXT;
	END;
END;
$$;;
