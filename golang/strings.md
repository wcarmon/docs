# Overview
- ...


# Definitions
1. [**Code point**](https://en.wikipedia.org/wiki/Code_point): same a rune, defined by [Unicode](https://en.wikipedia.org/wiki/Code_point)
1. **Rune**: a Code point (see above)
1. **String**: read-only, slice of (arbitrary) bytes
1. **Char/Character**: TODO


# Key features of strings
1. Go sources are always UTF-8
1. Conversion between `[]byte` and `string` is cheap
1. Strings can contain unprintable chars (can contain any bytes)
1. Zero value is empty string: `""`


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
| [String::`charAt`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#charAt(int)) |`( []rune("abc") )[3] == 'd'`|
| [String::`compareTo`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#compareTo(java.lang.String)) |`s1 < s2` or [`strings.Compare(...)`](https://pkg.go.dev/strings#Compare) |
| [String::`contains`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence)) |[`strings.Contains(haystack, needle)`](https://pkg.go.dev/strings#Contains) |
| [String::`endsWith`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String)) | [`strings.HasSuffix(s, sfx)`](https://pkg.go.dev/strings#HasSuffix) |
| [String::`equals`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object)) |`s1 == s2`|
| [String::`equalsIgnoreCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String)) | [`strings.EqualsFold(s1, s2)`](https://pkg.go.dev/strings#EqualFold) |
| [String::`format`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#format(java.lang.String,java.lang.Object...)) | [`fmt.Sprintf(s, ...)`](https://pkg.go.dev/fmt#Sprintf) |
| [String::`getBytes`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#getBytes()) |`[]byte(s)`|
| [String::`indexOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#indexOf(int)) | [`strings.Index(haystack, needle)`](https://pkg.go.dev/strings#Index) |
| [String::`isBlank`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank()) |[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace) |
| [String::`isEmpty`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isEmpty()) | [`len(s) == 0`](https://pkg.go.dev/builtin#len)] |
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
| String::valueOf|`string(foo)`|
| StringUtils::containsAny | [`strings.ContainsAny(haystack,needles)`](https://pkg.go.dev/strings#ContainsAny) |
| StringUtils::join | [`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join) |


TODO:
StringUtils.abbreviate			see below
StringUtils.appendIfMissing		...TODO: ??...
StringUtils.capitalize			see below
StringUtils.isAlpha			    ...TODO: ??...
StringUtils.isNumeric			...TODO: ??...
StringUtils.isAsciiPrintable	...TODO: ??...
StringUtils.leftPad			    see below
StringUtils.rightPad			see below
StringUtils.prependIfMissing	...TODO: ??...
StringUtils.remove/Delete		...TODO: ??...
StringUtils.replace			    ...TODO: ??...
StringUtils.substringLeft		...TODO: ??...
StringUtils.substringRight		...TODO: ??...
StringUtils.substringBefore		see below
StringUtils.substringBeforeLast	see below
StringUtils.substringAfter		see below
StringUtils.substringAfterLast	see below
StringUtils.uncapitalize		see below


TODO: raw strings
TODO: builder - https://yourbasic.org/golang/build-append-concatenate-strings-efficiently/
TODO: multi-line strings
TODO: concatenation - https://yourbasic.org/golang/build-append-concatenate-strings-efficiently/
TODO: strconv.Itoa


# Other resources
1. [Official docs](https://go.dev/blog/strings)
1. [yourbasic](https://yourbasic.org/golang/string-functions-reference-cheat-sheet)
