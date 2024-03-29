# Overview

1. Why Strings are problematic?
1. How can we do better?

# Strings make bad properties

1. `String` is ambiguous, because it can represent anything
1. `String` type provides zero information about structure
1. `String` is not self documenting. Future readers have no way of finding all possible values
1. `String` is not self verifying. The compiler & runtime don't have a way to enforce correct values
1. `String` properties discard all the benefits of type safety
1. `String` properties prevent JVM optimization
1. `String` properties prevent refactoring
1. `String` properties hinder code maintenance
1. `String` properties hinder code comprehension

# Making a `String` useful

1. Always prefer a better type [(examples below)](./strings.avoid.md#replace-string-with-)
1. Include Javadoc with structure assumptions
    1. Document acceptable characters, including case (eg. use regex)
    1. Document min & max length (eg. use regex)
    1. Document nullability
    1. Include an example
1. **Enforce** structure assumptions using preconditions (eg. use a [`Pattern`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/regex/Pattern.html))
1. Use a clear variable name
1. Add a link to any authoritative documentation that would help future readers/maintainers

# Examples of Useful Strings

```java
/**
 * Full US Postal zip code:
 * [0-9]{5}-[0-9]{4}
 *
 * eg. "08081-1234"
 */
final String fullZipCode;

/**
 * Unique ID within ABC company
 * [A-Z0-9]{6}
 *
 * eg. "1WC45Z"
 */
final String employeeId;

/**
 * As defined by RFC2822
 *
 * eg. "foo@bar.com"
 *
 * <p>See https://datatracker.ietf.org/doc/html/rfc2822
 */
final String emailAddress;

/**
 * Family/Last name
 * [A-Za-z- ]{3,32}
 *
 * eg. "Carmon"
 */
@Nullable
final String lastName;

/**
 * RGB hex value
 * [0-9a-f]{6} or empty-string (never null)
 *
 * eg. "00aaff"
 *
 * <p>See https://en.wikipedia.org/wiki/Web_colors
 */
final String hexColorCode;

/**
 * Minimum structure: [0-9-+ ]{12,16}
 * Parser imposes more strict structure
 *
 * eg. "+1 201-404-5555"
 */
final String phoneNumber;
```

# Replace String with ...

1. [`boolean`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Boolean.html) for Strings like `"Y"` & `"N"` or `"T"` & `"F"`
1. [`Duration`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Duration.html) or [`Period`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Period.html) for Strings that look like time periods/durations
1. [`Google LibPhoneNumber`](https://github.com/google/libphonenumber) for Strings containing phone numbers (or just a really clear Javadoc & regex [Pattern](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/regex/Pattern.html))
1. [`Instant`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Instant.html) for Strings that look like dates (no timezone info)
1. [`LocalTime`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/LocalTime.html) for Strings that look like times (eg. "When does the meeting start?")
1. [`long`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Long.html) or [`BigDecimal`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/math/BigDecimal.html) or [`double`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Double.html) for Strings that contain only numbers
1. [`Map`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html) for Strings that look like key-value pairs (eg. `"a=5,b=9,..."`)
1. [`MonthDay`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/MonthDay.html) for Strings with just month and day
1. [`OffsetDateTime`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/OffsetDateTime.html) for Strings with date-time & timezone
1. [`Path`](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/nio/file/Path.html) for Strings that looks like files/paths/directories
1. [`URI`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URI.html) for Strings that look like urls or resource addresses
1. [`UUID`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/UUID.html) for Strings containing a [uuid](https://en.wikipedia.org/wiki/Universally_unique_identifier)
1. [`WeekFields`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/temporal/WeekFields.html) or `int` for Strings containing a week
1. [`YearMonth`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/YearMonth.html) for Strings representing year and month
1. [`ZoneId`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/ZoneId.html) or [`ZoneOffset`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/ZoneOffset.html) for Strings containing timezone info
1. [Enum](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) for bounded set of values
1. [List or Set](./collections.selecting.md) for repeated values (eg. comma separated)
1. `char` for Strings that only contain 1 character
1. `int` for Strings containing a year
