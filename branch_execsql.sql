DO $$
DECLARE
	v int;
BEGIN
	EXECUTE $q$
		DROP TABLE IF EXISTS es_base;
		DROP VIEW IF EXISTS es_view;
		CREATE TABLE es_base(id int);
		CREATE VIEW es_view AS SELECT * FROM es_base;
		CREATE RULE es_ins AS ON INSERT TO es_view DO INSTEAD
			INSERT INTO es_base VALUES (NEW.id);
	$q$;

	/* rewritten command */
	INSERT INTO es_view VALUES (1);

	/* SPI_ERROR_COPY */
	BEGIN
		COPY (SELECT 1) TO STDOUT;
	EXCEPTION WHEN feature_not_supported THEN
		NULL;
	END;

	/* SPI_ERROR_TRANSACTION */
	BEGIN
		START TRANSACTION;
	EXCEPTION WHEN feature_not_supported THEN
		NULL;
	END;

	EXECUTE 'DROP VIEW es_view';
	EXECUTE 'DROP TABLE es_base';
END;
$$;;
