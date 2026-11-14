-- Show related bill, meter, customer records (up to 20).
SELECT t0."bill_id" AS "bill_bill_id",
       t0."period_start" AS "bill_period_start",
       t1."meter_id" AS "meter_meter_id",
       t1."serial_number" AS "meter_serial_number",
       t2."customer_id" AS "customer_customer_id",
       t2."name" AS "customer_name"
FROM portfolio."bill" t0
JOIN portfolio."meter" t1 ON t0."meter_id" = t1."meter_id"
JOIN portfolio."customer" t2 ON t1."customer_id" = t2."customer_id"
ORDER BY t0."bill_id", t1."meter_id", t2."customer_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."bill_id" AS "bill_bill_id",
       t0."period_start" AS "bill_period_start",
       t1."meter_id" AS "meter_meter_id",
       t1."serial_number" AS "meter_serial_number",
       t2."customer_id" AS "customer_customer_id",
       t2."name" AS "customer_name"
FROM portfolio."bill" t0
JOIN portfolio."meter" t1 ON t0."meter_id" = t1."meter_id"
JOIN portfolio."customer" t2 ON t1."customer_id" = t2."customer_id"
ORDER BY t0."bill_id", t1."meter_id", t2."customer_id"
LIMIT 20;

-- Find bill records where due_date matches "2026-02-15" (up to 20).
SELECT * FROM portfolio."bill"
WHERE "due_date" IS NOT DISTINCT FROM '2026-02-15'
ORDER BY "bill_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."bill"
WHERE "due_date" IS NOT DISTINCT FROM '2026-02-15'
ORDER BY "bill_id"
LIMIT 20;

-- Count payment records for each bill_id (up to 20 groups).
SELECT "bill_id", count(*) AS record_count
FROM portfolio."payment"
GROUP BY "bill_id"
ORDER BY record_count DESC, "bill_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "bill_id", count(*) AS record_count
FROM portfolio."payment"
GROUP BY "bill_id"
ORDER BY record_count DESC, "bill_id" NULLS LAST
LIMIT 20;
