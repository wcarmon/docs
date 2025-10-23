# Overview
1. Basic types in C++23+


# TL;DR
1. In general, prefer [`<cstdint>`](TODO)
1. Use `std::intN_t` ... only for I/O, wire formats, hashing, persistence, ABI boundaries


|C++|Rust|Java|
|---|---|---|
|`bool`|`bool`|`boolean`|
|TODO|TODO|char|
|`signed char`|`i8`|`byte`|
|`short` or `int16_t`|`i16`|`short`|
|`int` or `std::int32_t`|`i32`|`int`|
|`long long` or `std::int64_t`|`i64`|`long`|
|`unsigned char` or `std::uint8_t`|`u8`|N/A|
|`unsigned short`|`u16`|N/A|
|`unsigned int`|`u32`|N/A|
|`unsigned long long` or `std::uint64_t`|`u64`|N/A|
|`std::size_t`|`usize`|N/A|
|`std::ptrdiff_t`|`isize`|N/A|
|`float`|`f32`|`float`|
|`double`|`f64`|`double`|
|TODO|TODO|`BigInteger`|
|TODO|TODO|`BigDecimal`|


# TODO: unorganized
- is there a header for modern
- should I use the aliases in <cstdint>
- google style guide


# Other resources
1. https://en.cppreference.com/w/cpp/language/types.html
