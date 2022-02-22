# Overview
1. Why are strings bad
1. How we can do better


# Replace String with ...
1. [`boolean`] for Strings like "Y" & "N" or "T" & "F"
1. [`Path`](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/nio/file/Path.html) for Strings that looks like files/paths/directories
1. [`URI`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URI.html) for Strings that look like urls
1. [Collection](./collections.selecting.md) for repeated values (eg. comma separated)
1. [Enum](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) for bounded set of values
1. [java.time.Instant](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/Instant.html) for Strings that look like dates
