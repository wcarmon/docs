# Overview
1. How to build a proper utility class in Java 8+


# General Idioms
## **Item-0480**: Don't reinvent the wheel
1. Verify Core Java, Apache Commons & Guava are missing what you're building

## Core Java
TODO: https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Arrays.html

## Apache commons
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
TODO:


# Class definition idioms
## **Item-0482**: Javadoc
1. Add **brief** javadoc with summary of purpose

## **Item-0483**: Final
1. Mark the class `final`

## **Item-0484**: Stateless
1. No properties on the utility class
    1. `static final` constants are acceptable

## **Item-0485**: Naming
1. Package name: ends with `.util;` (Eg. `com.abc.foo.util`)
1. Class name: ends with `Utils` (eg. see Apache commons)
    1. Core java & Guava tend to name utils after a Type (eg. `Foos` contains methods to simplify using `Foo`)
    1. Avoid naming collisions by using the Utils suffix

## **Item-0486**: Constructor
1. `private` constructor, zero arguments






--------
# Method idioms
- Less than 75-lines per method
- Use method signatures consistent with other popular utilities (Apache Commons, Guava, ...)
- Ensure methods are stateless
- Ensure methods are [threadsafe](https://en.wikipedia.org/wiki/Thread_safety)


## Method Arguments


- 3 args max
- Stateless
- Tests required
- Lenient in args
- Strict on output
- preconditions

- Use modern types
- Never mutate args
- Document who is responsible for closing resources (like IO streams)
- No hard-coded time

- TODO: constants at the top as `private static final`
- TODO: final class
- TODO: no hard coded dates, pass clock
- TODO: only static methods

- TODO: preconditions on methods
- TODO: private constructor
