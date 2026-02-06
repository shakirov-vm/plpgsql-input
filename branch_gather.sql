DO $$
DECLARE
	v bigint;
BEGIN
	PERFORM set_config('max_parallel_workers_per_gather', '2', true);
	PERFORM set_config('parallel_setup_cost', '0', true);
	PERFORM set_config('parallel_tuple_cost', '0', true);

	v := (SELECT sum(i) FROM generate_series(1, 100000) AS i);
END;
$$;;
