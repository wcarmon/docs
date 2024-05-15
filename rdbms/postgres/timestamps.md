# Overview


# Idiom
1. Use (`BIGINT`) epoch seconds, epoch millis or (`VARCHAR`) iso8601 in UTC (eg. `2024-09-20T11:33:09Z`)
    1. Simplifies sorting
    1. Simplifies comparisons
    1. Simplifies prepared statements
    1. Increases portability of queries
    1. Simplifies timezone issues
    1. Allows Read/Write from multiple languages 
    1. Mechanical sympathy (for the `BIGINT`)
    1. Avoids casting in postgres queries
    1. JVM: Avoids legacy getters/setters related to `java.sql.Timestamp`
    1. JVM: Avoids conversion issues with buggy jdbc drivers    


# Builtin timestamps
- `timestamp with time zone` (8 bytes, same as `BIGINT`)
    - Java equivalent: [`OffsetDateTime`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/time/OffsetDateTime.html)    
- ~~`timestamp without time zone`~~ (8 bytes, same as `BIGINT`)
    - Java equivalent: [`LocalDateTime`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/time/LocalDateTime.html)
    - Ambiguous
    - Error prone for most use cases


# Gotchas
1. Some jdbc drivers have issues converting postgres timestamps to `java.time.*` 


# Measurements

## Epoch seconds
- `Postgres::BIGINT` epoch **seconds** represents 292,471,208,677 years
- ~~`Postgres::INTEGER`~~ epoch **seconds** represents 68 years

## Epoch millis
- `Postgres::BIGINT` epoch **millis** represents 292,471,208 years
- ~~`Postgres::INTEGER`~~ epoch **millis** represents ~~24 days~~
