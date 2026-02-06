DO $$
BEGIN
	BEGIN
		RAISE EXCEPTION USING
			ERRCODE = '23505',
			MESSAGE = 'msg',
			DETAIL = 'detail',
			HINT = 'hint',
			COLUMN = 'col',
			CONSTRAINT = 'con',
			DATATYPE = 'dtype',
			TABLE = 'tbl',
			SCHEMA = 'sch';
	EXCEPTION WHEN unique_violation THEN
		NULL;
	END;
END;
$$;;
