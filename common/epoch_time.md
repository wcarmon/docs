# Overview
1. Representing timestamps in a machine friendly way


# Epoch Milliseconds
1. Prefer this over seconds, or nanos
1. Rust:
    - Use [`i64`](https://doc.rust-lang.org/std/primitive.i64.html), covers years from `258195 BCE` to `258195 AD`
    - ~~`i32`~~ too small
    - ~~`u64`~~ incompatible with chrono
1. Java:
    - Use `long`, covers years from `258195 BCE` to `258195 AD`
    - ~~`int`~~ too small
1. Postgres:
    - Use [`bigint`](https://www.postgresql.org/docs/current/datatype-numeric.html), covers years from `258195 BCE` to `258195 AD`
    - ~~`integer`~~ too small

|Epoch millis| UTC Timestamp|
| ---|---|
|`    2_147_483_647`|`1970-01-25 20:31:23.647 UTC`|
|`  300_000_000_000`|`1979-07-05 05:20:00 UTC`|
|`  600_000_000_000`|`1989-01-05 10:40:00 UTC`|
|`  800_000_000_000`|`1995-05-09 06:13:20 UTC`|
|`  900_000_000_000`|`1998-07-09 16:00:00 UTC`|
|`1_000_000_000_000`|`2001-09-09 01:46:40 UTC`|
|`1_100_000_000_000`|`2004-11-09 11:33:20 UTC`|
|`1_300_000_000_000`|`2011-03-13 07:06:40 UTC`|
|`1_500_000_000_000`|`2017-07-14 02:40:00 UTC`|
|`1_700_000_000_000`|`2023-11-14 22:13:20 UTC`|
|`1_800_000_000_000`|`2027-01-15 08:00:00 UTC`|
|`1_900_000_000_000`|`2030-03-17 17:46:40 UTC`|
|`2_000_000_000_000`|`2033-05-18 03:33:20 UTC`|
|`2_500_000_000_000`|`2049-03-22 04:26:40 UTC`|
|`2_800_000_000_000`|`2058-09-23 09:46:40 UTC`|
|`3_200_000_000_000`|`2071-05-28 00:53:20 UTC`|
|`4_000_000_000_000`|`2096-10-02 07:06:40 UTC`|
|`7_000_000_000_000`|`2191-10-27 12:26:40 UTC`|
|`8_210_200_000_000_000`|`262140-11-17 23:06:40 UTC`|


# Epoch Seconds
1. Rust:
    - Use [`i64`](https://doc.rust-lang.org/std/primitive.i64.html), covers as many years as chrono can represent
    - ~~`i32`~~ too small (only up to year `2038 AD`)
1. Java:
    - Use `long`, covers as many years as chrono can represent
    - ~~`int`~~ too small (only up to year `2038 AD`)
1. Postgres:
    - Use [`bigint`](https://www.postgresql.org/docs/current/datatype-numeric.html), covers as many years as chrono can represent
    - ~~`integer`~~ too small (only up to year `2038 AD`)

|Epoch seconds| UTC Timestamp|
| ---|---|
| `  600_000_000`|`1989-01-05 10:40:00 UTC`|
| `  700_000_000`|`1992-03-07 20:26:40 UTC`|
| `  800_000_000`|`1995-05-09 06:13:20 UTC`|
| `  900_000_000`|`1998-07-09 16:00:00 UTC`|
|` 1_000_000_000`|`2001-09-09 01:46:40 UTC`|
|` 1_300_000_000`|`2011-03-13 07:06:40 UTC`|
|` 1_600_000_000`|`2020-09-13 12:26:40 UTC`|
|` 1_800_000_000`|`2027-01-15 08:00:00 UTC`|
|` 1_900_000_000`|`2030-03-17 17:46:40 UTC`|
|` 2_000_000_000`|`2033-05-18 03:33:20 UTC`|
|` 3_000_000_000`|`2065-01-24 05:20:00 UTC`|
|` 4_000_000_000`|`2096-10-02 07:06:40 UTC`|
|` 5_000_000_000`|`2128-06-11 08:53:20 UTC`|
|` 7_000_000_000`|`2191-10-27 12:26:40 UTC`|
|` 9_000_000_000`|`2255-03-14 16:00:00 UTC`|
|`10_000_000_000`|`2286-11-20 17:46:40 UTC`|


# Epoch Nanoseconds
1. Rust:
    - Use [`i64`](https://doc.rust-lang.org/std/primitive.i64.html), covers up to `2262-Apr-11`
    - ~~`i32`~~ way too small (only up to year `1970 AD`)
1. Java:
    - Use `long`
    - ~~`int`~~ way too small (only up to year `1970 AD`)
1. Postgres:
    - Use [`bigint`](https://www.postgresql.org/docs/current/datatype-numeric.html)
    - ~~`integer`~~ way too small (only up to year `1970 AD`)


|Epoch nanos| UTC Timestamp|
| ---|---|
| ` 800_000_000_000_000_000`|`1995-05-09 06:13:20 UTC`|
| ` 900_000_000_000_000_000`|`1998-07-09 16:00:00 UTC`|
|`1_000_000_000_000_000_000`|`2001-09-09 01:46:40 UTC`|
|`1_200_000_000_000_000_000`|`2008-01-10 21:20:00 UTC`|
|`1_500_000_000_000_000_000`|`2017-07-14 02:40:00 UTC`|
|`1_700_000_000_000_000_000`|`2023-11-14 22:13:20 UTC`|
|`1_800_000_000_000_000_000`|`2027-01-15 08:00:00 UTC`|
|`2_000_000_000_000_000_000`|`2033-05-18 03:33:20 UTC`|
|`3_000_000_000_000_000_000`|`2065-01-24 05:20:00 UTC`|
|`4_000_000_000_000_000_000`|`2096-10-02 07:06:40 UTC`|
|`7_000_000_000_000_000_000`|`2191-10-27 12:26:40 UTC`|
|`8_000_000_000_000_000_000`|`2223-07-06 14:13:20 UTC`|


# Other Resources
1. TODO
