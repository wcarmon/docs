# Overview
1. Overview of Strings, Runes, Code-points
1. Common methods and JVM equivalents


# Definitions
1. [**Code point**](https://en.wikipedia.org/wiki/Code_point): same a rune, defined by [Unicode](https://en.wikipedia.org/wiki/Code_point)
1. **Rune**: a Code point (see above)
1. **String**: read-only (immutable), slice of (arbitrary) bytes
1. **Char/Character**: TODO


# Key Concepts
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


# CaseFormat
1. Changing among `lowerCamel, UpperCamel, lower-kebab, lower_snake, UPPER_SNAKE, ...
1. github.com/iancoleman/strcase
1. github.com/bitly/nsq/internal/stringy

# Char Codes
1. See [ascii table](https://www.ascii-code.com/)
1. See [unicode table](https://unicode-table.com/en/)
1. Upper case letters from `A` == `65` to `Z` == `90`
1. Lower case letters from `a` == `97` to `z` == `122`

## Char code to letter
```go
upperA := string(65)    // A
upperZ := string(90)    // Z

lowerA := string(97)    // a
lowerZ := string(122)   // z
```

## Letter to char code
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


# String to runes (unicode)
```go
s := "abc"
[]rune(s) // []rune{97, 98, 99}

c := "🐧"
[]rune(c)[0] == 128039

// https://unicode-table.com/en/3088/
c := "よ"
[]rune(c)[0] == 12424  // \u3088

c := "🤣"
[]rune(c)[0] == 129315
```
- TODO: produce \u something (eg. fmt.Sprintf("%+q")


# Runes (unicode) to string
```go
r := []rune{97, 36}
string(r) == "a$"

r := rune(129315)   // 129315 (dec) == '\U0001F923' (codepoint)
string(r) == "🤣"

r := '\u3088'       // single quotes for rune, lowercase u for lower codepoints
string(r) == "よ"

r := '\U0001F923'   // uppercase U for higher code-points
string(r) == "🤣"

```


# Bytes to string
```go
// base 10 == dec
b := []byte{119, 99}
string(b) == "wc"
```
- TODO: hex example


# String to bytes
```go
s := "ab"
bytes.Equal([]byte(s), []byte{97, 98})
```


# Ascii code to String
```go
asc == 115  // base 10 == dec
string(asc) == "s"

b := []byte{115}
string(b) == "s"
```


# String to Ascii code
```go
s := "Q"
[]byte(s)[0] == 81 // base 10 == dec
```


# Printing runes
```go
r := []rune("😀")[0]
fmt.Printf("%d (dec) == %+q (code-point) == 0x%x (hex)",
    r, r, r)
// 128512 (dec) == '\U0001f600' (code-point) == 0x1f600 (hex)
```


# TODO/Unorganized
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

- TODO: builder - https://yourbasic.org/golang/build-append-concatenate-strings-efficiently/
- TODO: concatenation - https://yourbasic.org/golang/build-append-concatenate-strings-efficiently/
- TODO: strconv.Itoa


# Other Resources
1. [Official docs](https://go.dev/blog/strings)
1. [Official Language spec](https://go.dev/ref/spec#String_types)
1. [Official Language Spec for Rune literal](https://go.dev/ref/spec#Rune_literals)
1. [Official Language Spec for String literal](https://go.dev/ref/spec#String_literals)
1. https://www.practical-go-lessons.com/chap-7-hexadecimal-octal-ascii-utf8-unicode-runes
1. [yourbasic](https://yourbasic.org/golang/string-functions-reference-cheat-sheet)
