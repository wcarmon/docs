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
|[String::`charAt`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#charAt(int))|`( []rune("abc") )[3] == 'd'`|
|[String::`compareTo`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#compareTo(java.lang.String))|`s1 < s2` or [`strings.Compare(...)`](https://pkg.go.dev/strings#Compare)|
|[String::`contains`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence))|[`strings.Contains(haystack, needle)`](https://pkg.go.dev/strings#Contains)|
|[String::`endsWith`](TODO)|[`strings.HasSuffix(s, sfx)`](https://pkg.go.dev/strings#HasSuffix)|
|[String::`equals`](TODO)|`s1 == s2`|
|[String::`equalsIgnoreCase`](TODO)|[`strings.EqualsFold(s1, s2)`](https://pkg.go.dev/strings#EqualFold)|
|[String::`format`](TODO)|[`fmt.Sprintf(s, ...)`](https://pkg.go.dev/fmt#Sprintf)|
|[String::`getBytes`](TODO)|`[]byte(s)`|
|[String::`indexOf`](TODO)|[`strings.Index(haystack, needle)`](https://pkg.go.dev/strings#Index)|
|[String::`isEmpty`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isEmpty())|[[`len(s) == 0`](https://pkg.go.dev/builtin#len)]|
|[String::`lastIndexOf`](TODO)|[`strings.LastIndex(haystack, needle)`](https://pkg.go.dev/strings#LastIndex)|
|[String::`length`](TODO)|[`len(s)`](https://pkg.go.dev/builtin#len)|
|[String::`repeat`](TODO)|[`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat)|
|[String::`replaceAll`](TODO)|[`strings.ReplaceAll(...)`](https://pkg.go.dev/strings#ReplaceAll)|
|[String::`split`](TODO)|[`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split)|
|[String::`startsWith`](TODO)|[`strings.HasPrefix(s, pfx)`](https://pkg.go.dev/strings#HasPrefix)|
|[String::`substring`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#substring(int,int))|`"abcde"[2:4] == "cd"`|
|[String::`toCharArray`](TODO)|Use range in loops, or `[]rune(s)`|
|[String::`toLowerCase`](TODO)|[`strings.ToLower(s)`](https://pkg.go.dev/strings#ToLower)|
|[String::`toUpperCase`](TODO)|[`strings.ToUpper(s)`](https://pkg.go.dev/strings#ToUpper)|
|[String::`trim`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#trim())|[`strings.TrimSpace(s)`](https://pkg.go.dev/strings#TrimSpace)|
|[String::isBlank]()|[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace)|
|String::valueOf|`string(foo)`|
|StringUtils::join|[`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join)|
|StringUtils::containsAny|[`strings.ContainsAny(haystack,needles)`](https://pkg.go.dev/strings#ContainsAny)|


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
TODO: multi-line strings


# Other resources
1. [Official docs](https://go.dev/blog/strings)
1. [yourbasic](https://yourbasic.org/golang/string-functions-reference-cheat-sheet)
