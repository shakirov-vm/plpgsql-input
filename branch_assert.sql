DO $$
BEGIN
	BEGIN
		ASSERT 1 = 2, 'boom';
	EXCEPTION WHEN assert_failure THEN
		NULL;
	END;
END;
$$;;
