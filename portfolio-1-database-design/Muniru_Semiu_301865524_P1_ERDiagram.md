# Electricity / Utility Billing System — ER diagram

```mermaid
erDiagram
    direction LR
    customer {
        bigint customer_id PK
        text name
        text email UK
    }
    meter {
        bigint meter_id PK
        bigint customer_id FK
        text serial_number UK
        date installed_on
    }
    bill {
        bigint bill_id PK
        bigint meter_id FK
        date period_start
        date period_end
        date due_date
        numeric amount_due
    }
    payment {
        bigint payment_id PK
        bigint bill_id FK
        timestamptz received_at
        numeric amount
        text external_reference UK
    }
    customer ||--o{ meter : "customer_id"
    meter ||--o{ bill : "meter_id"
    bill ||--o{ payment : "bill_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Muniru_Semiu_301865524_ERDiagram.png)
