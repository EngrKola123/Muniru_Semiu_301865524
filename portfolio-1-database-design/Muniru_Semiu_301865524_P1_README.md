# Portfolio 1 — Database Design and Modelling

I organised the data into customer, meter, bill, payment. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| customer | 1 |
| meter | 1 |
| bill | 1 |
| payment | 1 |

The 30 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Muniru_Semiu_301865524_P1_Design.md)
- [ER diagram](Muniru_Semiu_301865524_P1_ERDiagram.md)
- [Normalisation](Muniru_Semiu_301865524_P1_Normalisation.md)
- [Schema](Muniru_Semiu_301865524_P1_Schema.sql)
- [Sample data](Muniru_Semiu_301865524_P1_SampleData.sql)
- [Constraint tests](Muniru_Semiu_301865524_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Muniru_Semiu_301865524_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

