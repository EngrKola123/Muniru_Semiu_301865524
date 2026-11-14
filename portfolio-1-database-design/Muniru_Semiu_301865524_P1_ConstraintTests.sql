-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. customer pk. Expected: pk_customer, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "name", "email")
VALUES (1, 'Jordan Lee', 'jordan.lee@example.test');

-- 2. customer unique email. Expected: uq_customer_0, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "name", "email")
VALUES (101, 'Casey Reed', 'avery.morgan@example.test');

-- 3. customer not null id. Expected: customer_id, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "name", "email")
VALUES (NULL, 'Taylor Quinn', 'taylor.quinn@example.test');

-- 4. customer not null name. Expected: name, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "name", "email")
VALUES (102, NULL, 'riley.park@example.test');

-- 5. customer not null email. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "name", "email")
VALUES (103, 'Sam Ellis', NULL);

-- 6. meter pk. Expected: pk_meter, SQLSTATE 23505.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (2, 1, 'MTR-2001', '2025-03-10');

-- 7. meter unique serial. Expected: uq_meter_0, SQLSTATE 23505.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (201, 1, 'MTR-1001', '2025-03-11');

-- 8. meter fk customer. Expected: fk_meter_0, SQLSTATE 23503.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (202, 999001, 'MTR-2002', '2025-03-12');

-- 9. meter not null id. Expected: meter_id, SQLSTATE 23502.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (NULL, 1, 'MTR-2003', '2025-03-13');

-- 10. meter not null customer. Expected: customer_id, SQLSTATE 23502.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (203, NULL, 'MTR-2004', '2025-03-14');

-- 11. meter not null serial. Expected: serial_number, SQLSTATE 23502.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (204, 1, NULL, '2025-03-15');

-- 12. meter not null installed. Expected: installed_on, SQLSTATE 23502.
INSERT INTO portfolio."meter" ("meter_id", "customer_id", "serial_number", "installed_on")
VALUES (205, 1, 'MTR-2005', NULL);

-- 13. bill pk. Expected: pk_bill, SQLSTATE 23505.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (3, 2, '2026-02-01', '2026-02-28', '2026-03-15', 92.25);

-- 14. bill unique meter period. Expected: uq_bill_0, SQLSTATE 23505.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (301, 2, '2026-01-01', '2026-01-31', '2026-02-20', 73.1);

-- 15. bill fk meter. Expected: fk_bill_0, SQLSTATE 23503.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (302, 999002, '2026-03-01', '2026-03-31', '2026-04-15', 80);

-- 16. bill not null id. Expected: bill_id, SQLSTATE 23502.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (NULL, 2, '2026-04-01', '2026-04-30', '2026-05-15', 81);

-- 17. bill not null meter. Expected: meter_id, SQLSTATE 23502.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (303, NULL, '2026-05-01', '2026-05-31', '2026-06-15', 82);

-- 18. bill not null start. Expected: period_start, SQLSTATE 23502.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (304, 2, NULL, '2026-06-30', '2026-07-15', 83);

-- 19. bill not null end. Expected: period_end, SQLSTATE 23502.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (305, 2, '2026-07-01', NULL, '2026-08-15', 84);

-- 20. bill not null due. Expected: due_date, SQLSTATE 23502.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (306, 2, '2026-08-01', '2026-08-31', NULL, 85);

-- 21. bill not null amount. Expected: amount_due, SQLSTATE 23502.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (307, 2, '2026-09-01', '2026-09-30', '2026-10-15', NULL);

-- 22. bill amount check. Expected: bill_amount_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."bill" ("bill_id", "meter_id", "period_start", "period_end", "due_date", "amount_due")
VALUES (308, 2, '2026-10-01', '2026-10-31', '2026-11-15', -1);

-- 23. payment pk. Expected: pk_payment, SQLSTATE 23505.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (4, 3, '2026-02-06T09:00:00Z', 15, 'PAY-2001');

-- 24. payment unique reference. Expected: uq_payment_0, SQLSTATE 23505.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (401, 3, '2026-02-06T10:00:00Z', 20, 'PAY-1001');

-- 25. payment fk bill. Expected: fk_payment_0, SQLSTATE 23503.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (402, 999003, '2026-02-07T10:00:00Z', 21, 'PAY-2002');

-- 26. payment not null id. Expected: payment_id, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (NULL, 3, '2026-02-08T10:00:00Z', 22, 'PAY-2003');

-- 27. payment not null bill. Expected: bill_id, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (403, NULL, '2026-02-09T10:00:00Z', 23, 'PAY-2004');

-- 28. payment not null received. Expected: received_at, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (404, 3, NULL, 24, 'PAY-2005');

-- 29. payment not null amount. Expected: amount, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (405, 3, '2026-02-10T10:00:00Z', NULL, 'PAY-2006');

-- 30. payment not null reference. Expected: external_reference, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "bill_id", "received_at", "amount", "external_reference")
VALUES (406, 3, '2026-02-11T10:00:00Z', 25, NULL);
