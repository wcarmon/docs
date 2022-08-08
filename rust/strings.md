# Overview

- TODO: https://cheats.rs/#strings-chars
- TODO: https://www.kuniga.me/docs/rust/#string
- TODO:


# Common operations
|JVM method|Golang|Rust|
|---|---|---|
| [String::`charAt`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#charAt(int)) | `"abc"[i:i+1]` or `( []rune("abc") )[3] == 'd'`| TODO |
| [String::`compareTo`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#compareTo(java.lang.String)) |`s1 < s2` or [`strings.Compare(...)`](https://pkg.go.dev/strings#Compare) | TODO |
| [String::`contains`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence)) |[`strings.Contains(haystack, needle)`](https://pkg.go.dev/strings#Contains) | TODO |
| [String::`endsWith`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String)) | [`strings.HasSuffix(s, sfx)`](https://pkg.go.dev/strings#HasSuffix) | TODO |
| [String::`equals`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object)) |`s1 == s2`| TODO |
| [String::`equalsIgnoreCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String)) | [`strings.EqualsFold(s1, s2)`](https://pkg.go.dev/strings#EqualFold) | TODO |
| [String::`format`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#format(java.lang.String,java.lang.Object...)) | [`fmt.Sprintf(s, ...)`](https://pkg.go.dev/fmt#Sprintf) | TODO |
| [String::`getBytes`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#getBytes()) |`[]byte(s)`| TODO |
| [String::`indexOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#indexOf(int)) | [`strings.Index(haystack, needle)`](https://pkg.go.dev/strings#Index) | TODO |
| [String::`isBlank`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank()) |[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace) | TODO |
| [String::`lastIndexOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#lastIndexOf(int)) | [`strings.LastIndex(haystack, needle)`](https://pkg.go.dev/strings#LastIndex) | TODO |
| [String::`length`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#length()) | [`len(s)`](https://pkg.go.dev/builtin#len) | TODO |
| [String::`repeat`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#repeat(int)) | [`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat) | TODO |
| [String::`replaceAll`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#replaceAll(java.lang.String,java.lang.String)) | [`strings.ReplaceAll(...)`](https://pkg.go.dev/strings#ReplaceAll) | TODO |
| [String::`split`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#split(java.lang.String)) | [`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split) | TODO |
| [String::`startsWith`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#startsWith(java.lang.String)) | [`strings.HasPrefix(s, pfx)`](https://pkg.go.dev/strings#HasPrefix) | TODO |
| [String::`substring`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#substring(int,int)) |`"abcde"[2:4] == "cd"`| TODO |
| [String::`toCharArray`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toCharArray()) |Use range in loops, or `[]rune(s)`| TODO |
| [String::`toLowerCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toLowerCase()) | [`strings.ToLower(s)`](https://pkg.go.dev/strings#ToLower) | TODO |
| [String::`toUpperCase`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toUpperCase()) | [`strings.ToUpper(s)`](https://pkg.go.dev/strings#ToUpper) | TODO |
| [String::`trim`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#trim()) |[`strings.TrimSpace(s)`](https://pkg.go.dev/strings#TrimSpace) | TODO |
| [String::`valueOf`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#valueOf(java.lang.Object)) |`string(foo)`| TODO |
| [StringUtils::`join`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html#join-java.lang.Iterable-java.lang.String-) | [`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join) | TODO |
| [StringUtils::containsAny](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html#containsAny-java.lang.CharSequence-char...-) | [`strings.ContainsAny(haystack,needles)`](https://pkg.go.dev/strings#ContainsAny) | TODO |
- TODO: generate from toml file


# Other resources
