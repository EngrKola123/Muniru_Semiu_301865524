# Electricity / Utility Billing System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| bill_id | payment records (list) |
| --- | --- |
| 3 | [4] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| payment.payment_id | payment.bill_id | payment.external_reference | bill.bill_id | bill.meter_id | meter.meter_id | meter.customer_id | meter.serial_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | 3 | PAY-1001 | 3 | 2 | 2 | 1 | MTR-1001 |

Key: payment_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## payment_example

| payment.payment_id | payment.bill_id | payment.external_reference | bill.bill_id | bill.meter_id | meter.meter_id | meter.customer_id | meter.serial_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | 3 | PAY-1001 | 3 | 2 | 2 | 1 | MTR-1001 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customer

| customer_id | name | email |
| --- | --- | --- |
| 1 | Avery Morgan | avery.morgan@example.test |

## meter

| meter_id | customer_id | serial_number | installed_on |
| --- | --- | --- | --- |
| 2 | 1 | MTR-1001 | 2024-06-15 |

## bill

| bill_id | meter_id | period_start | period_end | due_date | amount_due |
| --- | --- | --- | --- | --- | --- |
| 3 | 2 | 2026-01-01 | 2026-01-31 | 2026-02-15 | 84.5 |

## payment

| payment_id | bill_id | received_at | amount | external_reference |
| --- | --- | --- | --- | --- |
| 4 | 3 | 2026-02-05T14:30:00+00:00 | 84.5 | PAY-1001 |

## Dependencies

- customer: (customer_id) → name, email
- meter: (meter_id) → customer_id, serial_number, installed_on
- bill: (bill_id) → meter_id, period_start, period_end, due_date, amount_due
- payment: (payment_id) → bill_id, received_at, amount, external_reference

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
