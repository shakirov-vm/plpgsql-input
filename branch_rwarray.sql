DO $$
DECLARE
	arr int[] := ARRAY[1, 2, 3];
BEGIN
	arr[1] := 10;
	arr[2:3] := ARRAY[20, 30];
END;
$$;;
