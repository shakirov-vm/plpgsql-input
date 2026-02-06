CREATE PROCEDURE p_commit()
LANGUAGE plpgsql
AS $$
BEGIN
	COMMIT;
END;
$$;;

CREATE PROCEDURE p_call()
LANGUAGE plpgsql
AS $$
BEGIN
	CALL p_commit();
END;
$$;;

CALL p_call();;

DROP PROCEDURE p_call();;
DROP PROCEDURE p_commit();;
