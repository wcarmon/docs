# Overview
- ...


# Iteration
```go
// i == current index
// c == current character
for i, c := range "foo" {
  fmt.Println(i, c)
}
```


# Common operations
|JVM method|Golang|
|---|---|
|String::charAt|TODO|
|String::compareTo|`s1 < s2`|
|String::compareTo|TODO|
|String::contains|[`strings.Contains( haystack, needle)`](https://pkg.go.dev/strings#Contains)|
|String::endsWith|[`strings.HasSuffix( s, sfx)`](https://pkg.go.dev/strings#HasSuffix)|
|String::equalsIgnoreCase|[`strings.EqualsFold(s1, s2)`](https://pkg.go.dev/strings#EqualFold)|
|String::equals|`s1 == s2`|
|String::format|`fmt.Sprintf(s, ... )`|
|String::getBytes|`[]byte( s )`|
|String::indexOf|`strings.Index(haystack, needle)`|
|String::lastIndexOf|`strings.LastIndex(haystack, needle)`|
|String::length|`len(s)`|
|String::replaceAll|TODO|
|String::split|`strings.Split(s, sep)`|
|String::startsWith|`strings.HasPrefix(s, pfx)`|
|String::toCharArray|use range in loops, or `[]byte(s)`|
|String::toLowerCase|`strings.ToLower(s)`|
|String::toUpperCase|`strings.ToUpper(s)`|
|String::trim|`strings.TrimSpace(s)`|
|String::valueOf|`string(foo)`|
|StringUtils.isBlank|`len(strings.TrimSpace(s)) == 0`|
|StringUtils.isEmpty|`len(s) == 0`|
|StringUtils.join|`strings.Join( slice, sep )`|
|StringUtils.repeat|`strings.Repeat( s, n)`|
|StringUtils::containsAny|`strings.ContainsAny(haystack,needles)`|


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


# Other resources
TODO