DO $$
DECLARE
	r1 record;
	r2 record;
	rowv r1%ROWTYPE;
	t r1%ROWTYPE;
	nnrec r1%ROWTYPE;
BEGIN
	EXECUTE $q$
		DROP TABLE IF EXISTS as_tbl;
		CREATE TABLE as_tbl(a int, b text);
	$q$;

	-- ROW assignment: null source, then non-composite error
	BEGIN
		rowv := NULL;
		rowv := 1;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	-- RECORD assignment: null (ok), then non-composite error
	BEGIN
		r1 := NULL;
		r1 := 1;
	EXCEPTION WHEN datatype_mismatch THEN
		NULL;
	END;

	-- RECORD assignment from composite
	SELECT a, b INTO r2 FROM as_tbl LIMIT 0;
	r1 := r2;

	EXECUTE 'DROP TABLE as_tbl';
END;
$$;;
