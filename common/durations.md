# Overview
1. Representing durations in a machine friendly way


# TL;DR;
1. By default, Use `millis` for interop (eg. files, databases, etc)
1. By default, Use `i64` (rust), `long` (JVM), `int64` (golang, protobuf)
1. In code (in memory at runtime) ...
    - Rust: use [`std::time::Duration`](https://doc.rust-lang.org/std/time/struct.Duration.html)
    - Java: use [`java.time.Duration`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/time/Duration.html)
    - Golang: use [`time.Duration`](https://pkg.go.dev/time#Duration)
    - JS:
        - consider [day.js](https://day.js.org/docs/en/durations/durations)
        - consider standard [Number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number) for millis
1. In RDBMS ...
    - Postgres: use [`BIGINT`](https://www.postgresql.org/docs/current/datatype-numeric.html) for millis
    - SQLite: use [`BIGINT` (alias for dynamic sized int) or `INTEGER` (which grows up to 8 bytes based on inserted value)](https://www.sqlite.org/datatype3.html)
1. Serialized ...
    - Proto: use [`int64`](https://protobuf.dev/programming-guides/proto3/#scalar) for millis
    - JSON: use [Number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number) for millis


# Milliseconds Representation
1. Use millis unless you have a good reason to choose another
1. Rust:
    - `i32`: ~24 days
    - `u32`: ~45 days
    - **`i64`**: ~2_924_700  *centuries* ✅
1. Java:
    - `int`: ~24 days
    - **`long`**: ~2_924_700  *centuries* ✅
1. Postges:
    - `INTEGER`: ~24 days
    - **`BIGINT`**: ~2_924_700  *centuries* ✅


# Seconds Representation
1. Rust:
    - `i16`: 1 sec to ~9 hrs
    - `u16`: 1 sec to ~18 hrs
    - `i32`: 1 sec to ~68 years ✅
    - `u32`: 1 sec to ~136 years
    - `i64`: 1 sec to ~2_924_712_000 *centuries* ✅
    - `u64`: 1 sec to >4 billion *centuries*
1. Java:
    - `short`: 1 sec to ~9 hrs
    - `int`: 1 sec to ~68 years
    - `long`: 1 sec to ~2_924_712_000 *centuries*
1. Postges:
    - `SMALLINT`: ~9 hrs
    - `INTEGER`: ~68 years
    - `BIGINT`: ~2_924_712_000 *centuries*


# ~~Minutes Representation~~
1. Rust:
    - `i16`: 1 minute to ~22 days
    - `u16`: 1 minute to ~45 days
    - `i32`: 1 minute to ~40 *centuries*
    - `u32`: 1 minute to ~81 *centuries*
1. Java:
    - `short`: 1 minute to ~22 days
    - `int`: 1 minute to ~40 *centuries*
1. Postges:
    - `smallint`: 1 minute to ~22 days
    - `INTEGER`: 1 minute to ~40 *centuries*


# Conversion
|Use|Days|Hours|Minutes|Seconds|Millis|Micros|Nanos|
|---:| ---:| ---:| ---:| ---:| ---:| ---:| ---:|
|one|...|...|...|1|1_000|1_000_000|1_000_000_000|
|`i32`|...|...|...|1.2|2_147|2_147_484|**2_147_483_647**|
|`u32`|...|...|...|4.2|4_295|4_294_967|**4_294_967_295**|
|`i16`|...|...|...|32|**32_767**|32_767_000|32_767_000_000|
|one|...|...|1|60|60_000|60_000_000|60_000_000_000|
|`u16`|...|...|1.1|65.5|**65_535**|65_535_000|65_535_000_000|
|`i32`|...|...|35.8|2_147|2_147_484|**2_147_483_647**|2_147_483_647_000|
|one|...|1|60|3_600|3_600_000|3_600_000_000|...|
|`u32`|...|1.2|71.6|4_295|4_294_967|**4_294_967_295**|...|
|`i16`|...|9.1|546|**32_767**|32_767_000|32_767_000_000|...|
|`u16`|...|18.2|1_092|**65_535**|65_535_000|65_535_000_000|...|
|`i16`|22.7|546|**32_767**|1_966_020|1_966_020_000|...|...|
|one|1|24|1_440|86_400|86_400_000|86_400_000_000|...|
|`i32`|24.8|596.5|35_791|2_147_484|**2_147_483_647**|2_147_483_647_000|...|
|--|30|720|43_200|2_592_000|2_592_000_000|...|...|
|`u16`|45.5|1_092|**65_535**|3_932_100|3_932_100_000|3_932_100_000_000|...|
|`u32`|45.5|1_193|71_582|4_294_967|**4_294_967_295**|4_294_967_295_000|...|
|--|60|1_440|86_400|5_184_000|5_184_000_000|...|...|
|Quarter|90|2_160|129_600|7_776_000|7_776_000_000|...|...|
|--|120|2_880|172_800|10_370_000|10_370_000_000|...|...|
|half-year|180|4_320|259_200|15_550_000|15_550_000_000|...|...|
|year|365|8_760|525_600|31_540_000|31_540_000_000|...|...|
|`i16`|1_365|**32_767**|1_966_020|117_961_000|117_961_000_000|...|...|
|`u16`|2_731|**65_535**|3_932_100|235_926_000|235_926_000_000|...|...|
|`i32`|24_855|596_523|35_791_394|**2_147_483_647**|2_147_483_647_000|...|...|
|`i16`|**32_767**|786_408|47_184_480|2_831_070_000|2_831_070_000_000|...|...|


# Conversion: Beyond 1 Century
|Type|Days|Hours|Minutes|Seconds|Millis|Micros|Nanos|
|---:| ---:| ---:| ---:| ---:| ---:| ---:| ---:|
|--|36_500|876_000|52_560_000|3_153_600_000|3_153_600_000_000|...|...|
|`u32`|49_710|1_193_046|71_582_788|**4_294_967_295**|4_294_967_295_000|...|...|
|`u16`|**65_535**|1_572_840|94_370_400|5_662_220_000|...|...|...|
|`i64`|106_752|2_562_047|153_722_867|9_223_372_036|9_223_372_036_855|9_223_372_036_854_776|**9_223_372_036_854_775_807**|
|`u64`|213_503|5_124_096|307_445_735|18_446_744_074|18_446_744_074_000|...|**18_446_744_073_709_551_615**|
|`i32`|1_491_308|35_791_394|**2_147_483_647**|128_849_018_820|128_849_018_820_000|...|...|
|`u32`|2_982_616|71_582_788|**4_294_967_295**|257_698_037_700|257_698_037_700_000|...|...|
|`i32`|89_478_485|**2_147_483_647**|128_849_018_820|...|...|...|...|
|`i64`|106_751_991|2_562_047_788|153_722_867_281|...|...|**9_223_372_036_854_775_807**|...|
|`u32`|178_956_971|**4_294_967_295**|257_698_037_700|...|...|...|...|
|`i64`|106_751_991_167|2_562_047_788_015|153_722_867_280_913|9_223_372_036_854_776|**9_223_372_036_854_775_807**|...|...|
|`i64`|106_751_991_167_301|2_562_047_788_015_216|153_722_867_280_912_930|**9_223_372_036_854_775_807**|...|...|...|

- TODO: things at each scale
