# Overview

1. How to build a proper utility class in Java 8+

# **Item-0480**: Don't reinvent the wheel

1. You are probably reinventing the wheel :-)
1. Verify [Core Java](https://docs.oracle.com/en/java/javase/11/docs/api/), [Apache Commons](https://commons.apache.org/), [Guava](https://javadoc.io/doc/com.google.guava/guava/latest/index.html) & [Spring](https://docs.spring.io/spring-framework/docs/current/javadoc-api/) lack what you're building

## Core Java

1. [`Arrays`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Arrays.html)
1. [`Base64`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Base64.html)
1. [`Collections`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Collections.html)
1. [`Executors`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/Executors.html)
1. [`Files`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Files.html)
1. [`FileSystems`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/FileSystems.html)
1. [`Math`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Math.html)
1. [`Objects`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Objects.html)
1. [`Paths`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Paths.html)
1. [`Spliterators`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Spliterators.html)
1. [`TimeUnit`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/TimeUnit.html)

## Apache Commons

1. [`ArithmeticUtils`](https://commons.apache.org/proper/commons-math/javadocs/api-3.6.1/org/apache/commons/math3/util/ArithmeticUtils.html)
1. [`BagUtils`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/BagUtils.html)
1. [`BeanUtils`](https://commons.apache.org/proper/commons-beanutils/javadocs/v1.9.4/apidocs/org/apache/commons/beanutils/BeanUtils.html)
1. [`BooleanUtils`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/BooleanUtils.html)
1. [`CaseUtils`](https://commons.apache.org/proper/commons-text/apidocs/org/apache/commons/text/CaseUtils.html)
1. [`ClassUtils`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/ClassUtils.html)
1. [`CollectionUtils`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/CollectionUtils.html)
1. [`ComparatorUtils`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/ComparatorUtils.html)
1. [`ConvertUtils`](https://commons.apache.org/proper/commons-beanutils/javadocs/v1.9.4/apidocs/org/apache/commons/beanutils/ConvertUtils.html)
1. [`DbUtils`](https://commons.apache.org/proper/commons-dbutils/apidocs/org/apache/commons/dbutils/DbUtils.html)
1. [`DigestUtils`](https://commons.apache.org/proper/commons-codec/archives/1.15/apidocs/org/apache/commons/codec/digest/DigestUtils.html)
1. [`FileUtils`](https://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/FileUtils.html)
1. [`IOUtils`](https://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/IOUtils.html)
1. [`KeyManagerUtils`](https://commons.apache.org/proper/commons-net/apidocs/org/apache/commons/net/util/KeyManagerUtils.html)
1. [`ListUtils`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/ListUtils.html)
1. [`MapUtils`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/MapUtils.html)
1. [`MathUtils`](https://commons.apache.org/proper/commons-math/javadocs/api-3.6.1/org/apache/commons/math3/util/MathUtils.html)
1. [`MethodUtils`](https://commons.apache.org/proper/commons-beanutils/javadocs/v1.9.4/apidocs/org/apache/commons/beanutils/MethodUtils.html)
1. [`MimeMessageUtils`](https://commons.apache.org/proper/commons-email/javadocs/api-release/org/apache/commons/mail/util/MimeMessageUtils.html)
1. [`ObjectUtils`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/ObjectUtils.html)
1. [`PropertyUtils`](https://commons.apache.org/proper/commons-beanutils/javadocs/v1.9.4/apidocs/org/apache/commons/beanutils/PropertyUtils.html)
1. [`SSLContextUtils`](https://commons.apache.org/proper/commons-net/apidocs/org/apache/commons/net/util/SSLContextUtils.html)
1. [`StringEscapeUtils`](https://commons.apache.org/proper/commons-text/apidocs/org/apache/commons/text/StringEscapeUtils.html)
1. [`StringUtils`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html)
1. [`SystemUtils`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/SystemUtils.html)
1. [`TrieUtils`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/TrieUtils.html)
1. [`TrustManagerUtils`](https://commons.apache.org/proper/commons-net/apidocs/org/apache/commons/net/util/TrustManagerUtils.html)
1. [`WordUtils`](https://commons.apache.org/proper/commons-text/apidocs/org/apache/commons/text/WordUtils.html)

## Guava

1. [`Atomics`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/util/concurrent/Atomics.html)
1. [`Booleans`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/primitives/Booleans.html)
1. [`ByteStreams`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/io/ByteStreams.html)
1. [`Chars`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/primitives/Chars.html)
1. [`Closeables`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/io/Closeables.html)
1. [`Doubles`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/primitives/Doubles.html)
1. [`Escapers`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/escape/Escapers.html)
1. [`Files`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/io/Files.html)
1. [`Flushables`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/io/Flushables.html)
1. [`Graphs`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/graph/Graphs.html)
1. [`InetAddresses`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/net/InetAddresses.html)
1. [`Ints`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/primitives/Ints.html)
1. [`Iterables`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Iterables.html)
1. [`Iterators`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Iterators.html)
1. [`Lists`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Lists.html)
1. [`Longs`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/primitives/Longs.html)
1. [`Maps`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Maps.html)
1. [`MoreExecutors`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/util/concurrent/MoreExecutors.html)
1. [`MoreFiles`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/io/MoreFiles.html)
1. [`Multimaps`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Multimaps.html)
1. [`Multisets`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Multisets.html)
1. [`ObjectArrays`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/ObjectArrays.html)
1. [`Preconditions`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/base/Preconditions.html)
1. [`Primitives`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/primitives/Primitives.html)
1. [`Queues`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Queues.html)
1. [`Runnables`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/util/concurrent/Runnables.html)
1. [`Sets`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Sets.html)
1. [`Stats`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/math/Stats.html)
1. [`Strings`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/base/Strings.html)
1. [`Tables`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/collect/Tables.html)
1. [`Uninterruptibles`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/util/concurrent/Uninterruptibles.html)
1. [`UrlEscapers`](https://javadoc.io/static/com.google.guava/guava/31.0.1-jre/com/google/common/net/UrlEscapers.html)

## Spring (Prefer Apache Commons & Guava over Spring utils)

1. [`AnnotationUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/core/annotation/AnnotationUtils.html)
1. [`Base64Utils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/Base64Utils.html)
1. [`BeanUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/beans/BeanUtils.html)
1. [`ClassUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/ClassUtils.html)
1. [`DataSourceUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/jdbc/datasource/DataSourceUtils.html)
1. [`DomUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/xml/DomUtils.html)
1. [`FileSystemUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/FileSystemUtils.html)
1. [`MimeTypeUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/MimeTypeUtils.html)
1. [`ReflectionTestUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/test/util/ReflectionTestUtils.html)
1. [`SystemPropertyUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/SystemPropertyUtils.html)
1. [`UriUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/util/UriUtils.html)
1. [`ValidationUtils`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/validation/ValidationUtils.html)

# **Item-0482**: Javadoc

1. Add **brief** javadoc, with a summary of purpose
1. Document who is responsible for closing resources (like [IO Streams](https://docs.oracle.com/javase/tutorial/essential/io/streams.html))
    1. `Caller is responsible` or `callee is responsible`

# **Item-0483**: Final

1. Mark the utility class `final`

# **Item-0484**: Stateless

1. No instance properties on the utility class
    1. `static final` constants are acceptable (at top of file)

# **Item-0485**: Naming

1. Package name: ends with `.util;` (Eg. `com.abc.util`)
1. Class name: ends with `Utils` (eg. see Apache commons examples above)
    1. Core Java & [Guava](https://github.com/google/guava) tend to name utils after a Type (eg. `Foos` contains methods to simplify using `Foo`)
    1. [Apache Commons](https://commons.apache.org/) and [Spring](https://docs.spring.io/spring-framework/docs/current/reference/html) tend to name utilities with the `Utils` suffix
    1. Avoid naming collisions by using the `Utils` suffix (and not reinventing the wheel)

# **Item-0486**: Constructor

1. `private` constructor
1. Exactly one constructor
1. constructor accepts zero arguments

# **Item-0487**: Methods

1. **Length**: Less than 75-lines per method
1. **Args**: Add [Preconditions](./preconditions.md) on method args (unless they are nullable)
1. All methods must be `static`
1. Use method signatures consistent with other popular utilities (Apache Commons, Guava, ...)
1. Ensure all methods are Stateless
1. Ensure all methods are [threadsafe](https://en.wikipedia.org/wiki/Thread_safety)
1. Three arguments max. Accept a POJO if you need mor args.
1. Never mutate method Arguments

# **Item-0488**: Tests

1. Add "enough" tests to exercise both positive and negative cases

--------

# TODO: Find a home for these

- Lenient in args, Strict on output
- Use modern types
- no hard coded dates, pass clock
