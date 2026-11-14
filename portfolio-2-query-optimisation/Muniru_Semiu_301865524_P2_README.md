# Electricity / Utility Billing System — SQL queries

## 1. Show related bill, meter, customer records (up to 20).

```sql
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
```

| bill_bill_id | bill_period_start | meter_meter_id | meter_serial_number | customer_customer_id | customer_name |
| --- | --- | --- | --- | --- | --- |
| 3 | 2026-01-01 | 2 | MTR-1001 | 1 | Avery Morgan |

## 2. Find bill records where due_date matches "2026-02-15" (up to 20).

```sql
SELECT * FROM portfolio."bill"
WHERE "due_date" IS NOT DISTINCT FROM '2026-02-15'
ORDER BY "bill_id"
LIMIT 20;
```

| bill_id | meter_id | period_start | period_end | due_date | amount_due |
| --- | --- | --- | --- | --- | --- |
| 3 | 2 | 2026-01-01 | 2026-01-31 | 2026-02-15 | 84.5 |

## 3. Count payment records for each bill_id (up to 20 groups).

```sql
SELECT "bill_id", count(*) AS record_count
FROM portfolio."payment"
GROUP BY "bill_id"
ORDER BY record_count DESC, "bill_id" NULLS LAST
LIMIT 20;
```

| bill_id | record_count |
| --- | --- |
| 3 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.944 | 1.052, 0.944, 0.942 | Sort → Seq Scan | 112 |
| After index | 0.179 | 0.202, 0.17, 0.179 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.944 ms to 0.179 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.915..0.917 rows=20 loops=1)
  Seq Scan on bill (actual time=0.016..0.876 rows=20 loops=1)
Planning Time: 0.33 ms
Execution Time: 1.052 ms
```

### Before index, run 2

```text
Sort (actual time=0.914..0.915 rows=20 loops=1)
  Seq Scan on bill (actual time=0.015..0.879 rows=20 loops=1)
Planning Time: 0.336 ms
Execution Time: 0.944 ms
```

### Before index, run 3

```text
Sort (actual time=0.912..0.914 rows=20 loops=1)
  Seq Scan on bill (actual time=0.015..0.878 rows=20 loops=1)
Planning Time: 0.39 ms
Execution Time: 0.942 ms
```

### After index, run 1

```text
Sort (actual time=0.148..0.15 rows=20 loops=1)
  Bitmap Heap Scan on bill (actual time=0.025..0.113 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.012 rows=20 loops=1)
Planning Time: 0.528 ms
Execution Time: 0.202 ms
```

### After index, run 2

```text
Sort (actual time=0.118..0.119 rows=20 loops=1)
  Bitmap Heap Scan on bill (actual time=0.025..0.083 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.012 rows=20 loops=1)
Planning Time: 0.522 ms
Execution Time: 0.17 ms
```

### After index, run 3

```text
Sort (actual time=0.127..0.128 rows=20 loops=1)
  Bitmap Heap Scan on bill (actual time=0.024..0.09 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.012 rows=20 loops=1)
Planning Time: 0.558 ms
Execution Time: 0.179 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Muniru_Semiu_301865524_P2_Queries.sql, then Muniru_Semiu_301865524_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Muniru_Semiu_301865524_P2_QueryResults.png) · [Index comparison](screenshots/Muniru_Semiu_301865524_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

