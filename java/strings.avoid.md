# Overview
1. Why are strings bad
1. How we can do better


# Bad because
1. Strings can represent anything


# Replace String with ...
1. [`boolean`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Boolean.html) for Strings like "Y" & "N" or "T" & "F"
1. [`Duration`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Duration.html) or [`Period`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Period.html) for Strings that look like time periods
1. [`Instant`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Instant.html) for Strings that look like dates
1. [`long`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Long.html) or [`BigDecimal`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/math/BigDecimal.html) or [`double`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Double.html) for Strings that contain only numbers
1. [`Path`](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/nio/file/Path.html) for Strings that looks like files/paths/directories
1. [`URI`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URI.html) for Strings that look like urls
1. [Enum](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) for bounded set of values
1. [List or Set](./collections.selecting.md) for repeated values (eg. comma separated)



----------
# TODO: Find a home for these
- TODO: BYTE_ARRAY
- TODO: CHAR
- TODO: COLOR
- TODO: MAP
- TODO: MONTH_DAY
- TODO: UTC_TIME
- TODO: UUID
- TODO: WEEK_OF_YEAR
- TODO: YEAR
- TODO: YEAR_MONTH
- TODO: ZONE_AGNOSTIC_DATE
- TODO: ZONE_AGNOSTIC_DATE_TIME
- TODO: ZONE_AGNOSTIC_TIME
- TODO: ZONE_OFFSET
- TODO: ZONED_DATE_TIME

- TODO: EMAIL
- TODO: PHONE_NUMBER
