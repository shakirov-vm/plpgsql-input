CREATE PROCEDURE p_commit()
LANGUAGE plpgsql
AS $$
BEGIN
	COMMIT;
END;
$$;;

CREATE PROCEDURE p_rollback()
LANGUAGE plpgsql
AS $$
BEGIN
	ROLLBACK;
END;
$$;;

CALL p_commit();;
CALL p_rollback();;

DROP PROCEDURE p_rollback();;
DROP PROCEDURE p_commit();;
