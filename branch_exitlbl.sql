DO $$
BEGIN
	<<outer>>
	BEGIN
		<<inner>>
		BEGIN
			EXIT outer;
		END inner;
	END outer;
END;
$$;;
