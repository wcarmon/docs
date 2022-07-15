# Overview
- Overview of Strings, Runes, Code-points
- Common methods and JVM equivalents


# Definitions
1. [**Code point**](https://en.wikipedia.org/wiki/Code_point): same a rune, defined by [Unicode](https://en.wikipedia.org/wiki/Code_point)
1. **Rune**: a Code point (see above)
1. **String**: read-only (immutable), slice of (arbitrary) bytes
1. **Char/Character**: TODO


# Key features of strings
1. Go sources are always UTF-8
1. Conversion between `[]byte` and `string` is cheap
1. Strings can contain unprintable chars (can contain any bytes)
1. Zero value is empty string: `""`


# Literals
- TODO: raw strings - https://go.dev/ref/spec#String_literals
- TODO: multi-line strings - Backquote: raw strings, multi-line, not-interpreted, cannot contain backquote


# Iteration
```go
// i == current index
// c == current character
for i, c := range "foo" {
  fmt.Println(i, c)
}
```


# Idioms
1. Avoid bytes for presentation, use runes instead
    1. Runes are safe for multi-byte chars
    1. `[]byte` and `string` are fine for serialization, storage, ...


# Common operations
|JVM method|Golang|
|---|---|
| [String::`charAt`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#charAt(int)) | `"abc"[i:i+1]` or `( []rune("abc") )[3] == 'd'`|
| [String::`compareTo`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#compareTo(java.lang.String)) |`s1 < s2` or [`strings.Compare(...)`](https://pkg.go.dev/strings#Compare) |
| [String::`contains`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence)) |[`strings.Contains(haystack, needle)`](https://pkg.go.dev/strings#Contains) |
| [String::`endsWith`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String)) | [`strings.HasSuffix(s, sfx)`](https://pkg.go.dev/strings#HasSuffix) |
| [String::`equals`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object)) |`s1 == s2`|
| [String::`equalsIgnoreCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String)) | [`strings.EqualsFold(s1, s2)`](https://pkg.go.dev/strings#EqualFold) |
| [String::`format`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#format(java.lang.String,java.lang.Object...)) | [`fmt.Sprintf(s, ...)`](https://pkg.go.dev/fmt#Sprintf) |
| [String::`getBytes`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#getBytes()) |`[]byte(s)`|
| [String::`indexOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#indexOf(int)) | [`strings.Index(haystack, needle)`](https://pkg.go.dev/strings#Index) |
| [String::`isBlank`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank()) |[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace) |
| [String::`isEmpty`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isEmpty()) | [`len(s) == 0`](https://pkg.go.dev/builtin#len) |
| [String::`lastIndexOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#lastIndexOf(int)) | [`strings.LastIndex(haystack, needle)`](https://pkg.go.dev/strings#LastIndex) |
| [String::`length`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#length()) | [`len(s)`](https://pkg.go.dev/builtin#len) |
| [String::`repeat`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#repeat(int)) | [`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat) |
| [String::`replaceAll`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#replaceAll(java.lang.String,java.lang.String)) | [`strings.ReplaceAll(...)`](https://pkg.go.dev/strings#ReplaceAll) |
| [String::`split`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#split(java.lang.String)) | [`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split) |
| [String::`startsWith`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#startsWith(java.lang.String)) | [`strings.HasPrefix(s, pfx)`](https://pkg.go.dev/strings#HasPrefix) |
| [String::`substring`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#substring(int,int)) |`"abcde"[2:4] == "cd"`|
| [String::`toCharArray`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toCharArray()) |Use range in loops, or `[]rune(s)`|
| [String::`toLowerCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toLowerCase()) | [`strings.ToLower(s)`](https://pkg.go.dev/strings#ToLower) |
| [String::`toUpperCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toUpperCase()) | [`strings.ToUpper(s)`](https://pkg.go.dev/strings#ToUpper) |
| [String::`trim`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#trim()) |[`strings.TrimSpace(s)`](https://pkg.go.dev/strings#TrimSpace) |
| [String::`valueOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#valueOf(java.lang.Object)) |`string(foo)`|
| [StringUtils::`join`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html#join-java.lang.Iterable-java.lang.String-) | [`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join) |
| [StringUtils::containsAny](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html#containsAny-java.lang.CharSequence-char...-) | [`strings.ContainsAny(haystack,needles)`](https://pkg.go.dev/strings#ContainsAny) |


- TODO: StringUtils.abbreviate			TODO
- TODO: StringUtils.appendIfMissing		...TODO: ??...
- TODO: StringUtils.capitalize			TODO
- TODO: StringUtils.isAlpha			    ...TODO: ??...
- TODO: StringUtils.isNumeric			...TODO: ??...
- TODO: StringUtils.isAsciiPrintable	...TODO: ??...
- TODO: StringUtils.leftPad			    fmt.Printf("%06d", 12)
- TODO: StringUtils.rightPad			fmt.Printf("%06d", 12)
- TODO: StringUtils.prependIfMissing	...TODO: ??...
- TODO: StringUtils.remove/Delete		...TODO: ??...
- TODO: StringUtils.replace			    ...TODO: ??...
- TODO: StringUtils.substringLeft		...TODO: ??...
- TODO: StringUtils.substringRight		...TODO: ??...
- TODO: StringUtils.substringBefore		see below
- TODO: StringUtils.substringBeforeLast	see below
- TODO: StringUtils.substringAfter		see below
- TODO: StringUtils.substringAfterLast	see below
- TODO: StringUtils.uncapitalize		see below

--------
- TODO: builder - https://yourbasic.org/golang/build-append-concatenate-strings-efficiently/
- TODO: concatenation - https://yourbasic.org/golang/build-append-concatenate-strings-efficiently/
- TODO: strconv.Itoa


# CaseFormat
1. Changing among `lowerCamel, UpperCamel, lower-kebab, lower_snake, UPPER_SNAKE, ...
1. github.com/iancoleman/strcase
1. github.com/bitly/nsq/internal/stringy


# Char code to letter
```go
upperA := string(65)    // A
upperZ := string(90)    // Z

lowerA := string(97)    // a
lowerZ := string(122)   // z
```

# letter to Char code
```go
// -- upper case
codeForA := int('A') // 65
codeForA := "ABC"[0] // 65 (only for ascii)
codeForA := []rune("ABC")[0] // 65 (only for any unicode)
...
codeForZ := int('Z') // 90

// -- lower case
codeForA := int('a') // 97
...
codeForZ := int('z') // 122
```


# Other resources
1. [Official docs](https://go.dev/blog/strings)
1. [Official Language spec](https://go.dev/ref/spec#String_types)
1. [Official Language Spec for Rune literal](https://go.dev/ref/spec#Rune_literals)
1. [Official Language Spec for String literal](https://go.dev/ref/spec#String_literals)
1. https://www.practical-go-lessons.com/chap-7-hexadecimal-octal-ascii-utf8-unicode-runes
1. [yourbasic](https://yourbasic.org/golang/string-functions-reference-cheat-sheet)
