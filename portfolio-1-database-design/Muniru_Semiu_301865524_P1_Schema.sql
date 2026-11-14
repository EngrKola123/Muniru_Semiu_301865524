-- Electricity / Utility Billing System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."customer" (
  "customer_id" bigint NOT NULL,
  "name" text NOT NULL,
  "email" text NOT NULL,
  CONSTRAINT "pk_customer" PRIMARY KEY ("customer_id"),
  CONSTRAINT "uq_customer_0" UNIQUE ("email")
);
CREATE TABLE portfolio."meter" (
  "meter_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  "serial_number" text NOT NULL,
  "installed_on" date NOT NULL,
  CONSTRAINT "pk_meter" PRIMARY KEY ("meter_id"),
  CONSTRAINT "uq_meter_0" UNIQUE ("serial_number")
);
CREATE TABLE portfolio."bill" (
  "bill_id" bigint NOT NULL,
  "meter_id" bigint NOT NULL,
  "period_start" date NOT NULL,
  "period_end" date NOT NULL,
  "due_date" date NOT NULL,
  "amount_due" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_bill" PRIMARY KEY ("bill_id"),
  CONSTRAINT "uq_bill_0" UNIQUE ("meter_id", "period_start")
);
CREATE TABLE portfolio."payment" (
  "payment_id" bigint NOT NULL,
  "bill_id" bigint NOT NULL,
  "received_at" timestamptz NOT NULL,
  "amount" numeric(18,2) NOT NULL,
  "external_reference" text NOT NULL,
  CONSTRAINT "pk_payment" PRIMARY KEY ("payment_id"),
  CONSTRAINT "uq_payment_0" UNIQUE ("external_reference")
);
ALTER TABLE portfolio."meter" ADD CONSTRAINT "fk_meter_0" FOREIGN KEY ("customer_id") REFERENCES portfolio."customer" ("customer_id");
ALTER TABLE portfolio."bill" ADD CONSTRAINT "fk_bill_0" FOREIGN KEY ("meter_id") REFERENCES portfolio."meter" ("meter_id");
ALTER TABLE portfolio."payment" ADD CONSTRAINT "fk_payment_0" FOREIGN KEY ("bill_id") REFERENCES portfolio."bill" ("bill_id");
ALTER TABLE portfolio."bill" ADD CONSTRAINT "bill_amount_nonnegative" CHECK ("amount_due" >= 0);
COMMIT;
