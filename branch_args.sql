DO $$
BEGIN
	EXECUTE $q$
		DROP FUNCTION IF EXISTS f_args(t_args, int[], int);
		DROP TYPE IF EXISTS t_args;
		CREATE TYPE t_args AS (a int, b text);
		CREATE FUNCTION f_args(p_rec t_args, p_arr int[], p_num int)
		RETURNS int
		LANGUAGE plpgsql
		AS $fn$
		BEGIN
			RETURN COALESCE(p_rec.a, 0) + p_num
				+ COALESCE(array_length(p_arr, 1), 0);
		END;
		$fn$;
	$q$;

	PERFORM f_args(ROW(1, 'x')::t_args, ARRAY[1,2,3], 5);
	PERFORM f_args(NULL::t_args, ARRAY[10,20], 1);

	EXECUTE 'DROP FUNCTION f_args(t_args, int[], int)';
	EXECUTE 'DROP TYPE t_args';
END;
$$;;
