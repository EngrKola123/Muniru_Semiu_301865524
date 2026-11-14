-- Fictional sample records for Electricity / Utility Billing System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customer" ("customer_id", "name", "email") VALUES (1, 'Avery Morgan', 'avery.morgan@example.test');
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on") VALUES (2, 1, 'MTR-1001', '2024-06-15');
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due") VALUES (3, 2, '2026-01-01', '2026-01-31', '2026-02-15', 84.5);
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference") VALUES (4, 3, '2026-02-05T14:30:00Z', 84.5, 'PAY-1001');
COMMIT;
