CREATE PROCEDURE p_commit_chain()
LANGUAGE plpgsql
AS $$
BEGIN
	COMMIT AND CHAIN;
END;
$$;;

CREATE PROCEDURE p_rollback_chain()
LANGUAGE plpgsql
AS $$
BEGIN
	ROLLBACK AND CHAIN;
END;
$$;;

CALL p_commit_chain();;
CALL p_rollback_chain();;

DROP PROCEDURE p_rollback_chain();;
DROP PROCEDURE p_commit_chain();;
