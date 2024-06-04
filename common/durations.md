# Overview
1. Representing durations in a machine friendly way


# Hours
1. Rust:
1. Java:
1. Postges:

- TODO: u16, u32, u64, u128


# Minutes
1. Rust:
1. Java:
1. Postges:

# Seconds
1. Rust:
1. Java:
1. Postges:

# Milliseconds
1. Rust:
1. Java:
1. Postges:


# Nanoseconds
1. Rust:
1. Java:
1. Postges:


|Hours|Minutes|Seconds|Millis|Micros|Nanos|
| ---:| ---:| ---:| ---:| ---:| ---:|
|1|60|3_600|3_600_000|3_600_000_000|--|
|--|1|60|60_000|60_000_000|--|
|--|--|1|1_000|1_000_000|1_000_000_000|
|--|--|--|1|1_000|1_000_000|
|--|--|--|--|1|1_000|
|**65_535**|3_932_100|235_926_000|--|--|--|
|1092.25|65_535|3_932_100|TODO|--|--|
|18.2|1092.25|**65_535**|65_535_000|--|--|
|--|1.09|65.5|**65_535**|65_535_000|--|
|**4_294_967_295**|TODO|TODO|TODO|||
|TODO|**4_294_967_295**|TODO|TODO|TODO||
||TODO|**4_294_967_295**|TODO|TODO||
||TODO|TODO|**4_294_967_295**|TODO|TODO|
|||TODO|TODO|**4_294_967_295**|TODO|
||||TODO|TODO|**4_294_967_295**|
|||||||


- TODO: u32 max = 4_294_967_295
- TODO: u64 max = 18_446_744_073_709_551_615
- TODO: java.int max = 2_147_483_647
- TODO: java.long max = 9_223_372_036_854_775_807
- TODO: things at each scale
