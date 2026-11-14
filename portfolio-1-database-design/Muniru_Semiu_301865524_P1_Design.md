# Electricity / Utility Billing System — database design

My case study records customer, meter, bill, payment.

## Users

- Utility billing clerks
- Accounts staff
- Customers reviewing bills and payments

## Main operations

- Register a customer and meter
- Issue a bill for a meter billing period
- Record a payment against a bill
- Review bills and aggregate payments by customer

## Entities

| Entity | Information stored |
| --- | --- |
| customer | A person or organization receiving utility service and bills. |
| meter | A utility meter assigned to one customer. |
| bill | A dated charge issued for one meter and billing period. |
| payment | A payment received for one bill. |

## customer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
- Unique key: (email).

## meter

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| meter_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| serial_number | TEXT | Unique | Yes |
| installed_on | DATE |  | Yes |
- customer_id → customer.customer_id
- Unique key: (serial_number).

## bill

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| bill_id | BIGINT | PK | Yes |
| meter_id | BIGINT | FK | Yes |
| period_start | DATE |  | Yes |
| period_end | DATE |  | Yes |
| due_date | DATE |  | Yes |
| amount_due | NUMERIC(18,2) |  | Yes |
- meter_id → meter.meter_id
- Unique key: (meter_id, period_start).

## payment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| payment_id | BIGINT | PK | Yes |
| bill_id | BIGINT | FK | Yes |
| received_at | TIMESTAMPTZ |  | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| external_reference | TEXT | Unique | Yes |
- bill_id → bill.bill_id
- Unique key: (external_reference).

## Relationships and business rules

- Each customer email identifies at most one customer.
- Every meter must reference an existing customer.
- A meter can have at most one bill with a given period start date.
- A bill amount due cannot be negative.
- Every payment must reference an existing bill.
- A payment source reference can be recorded only once.

## Assumptions

- Each meter belongs to one customer; each bill belongs to one meter; each payment belongs to one bill.
- A meter may have at most one bill for a given period start date.
- Amounts are nonnegative decimal values; this exercise does not model tariffs, taxes, partial-payment balances, or meter-reading calculations.
- A payment external reference is supplied by the payment source and must be unique.
- Worked normalisation example rooted at payment: payment stores bill_id as a foreign key, while bill period and meter facts remain in bill and meter; customer facts remain in customer, avoiding repeated ancestor details in payment.
- Benchmark plan: generate 20000 synthetic bills, compare due-date filtering with and without the proposed B-tree index using the same query and data, and inspect the planned access path. This is a proposed exercise, not a reported measurement.

