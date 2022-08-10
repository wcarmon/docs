# String Operations

|`Operation`|[`Go`](https://go.dev/)|[`Rust`](https://www.rust-lang.org/)|[`Java`](https://docs.oracle.com/javase/8/docs/technotes/guides/language/)|
|---|---|---|---|
|contains|[`strings.Contains($EXPR$, needle)`](https://pkg.go.dev/strings#Contains)|[`$EXPR$.contains(needle)`](https://doc.rust-lang.org/std/primitive.str.html#method.contains)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence))|
|endswith|[`strings.HasSuffix($EXPR$, sfx)`](https://pkg.go.dev/strings#HasSuffix)|[`$EXPR$.ends_with(sfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.ends_with)|[`$EXPR$.endsWith(sfx)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String))|
|equals|[`$EXPR$ == s2`](https://go.dev/ref/spec#Comparison_operators)|[`$EXPR$ == s2`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#tymethod.eq)|[`$EXPR$.equals(s2)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object))|
|equalsIgnoreCase|[`strings.EqualsFold($EXPR$, s2)`](https://pkg.go.dev/strings#EqualFold)|[`$EXPR$.eq_ignore_ascii_case(&s2)`](https://doc.rust-lang.org/std/primitive.str.html#method.eq_ignore_ascii_case)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String))|
|isBlank|[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim().is_empty()`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank())|
|isEmpty|[`len($EXPR$) == 0`](https://pkg.go.dev/builtin#len)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.is_empty)|[`$EXPR$.isEmpty`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#isEmpty())|
|join|[`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join)|[`vec!["a", "b", "c"].join(sep);`](https://doc.rust-lang.org/std/primitive.slice.html#method.join)|[`String.join(" ", List.of("a", "b", "c"))`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#join(java.lang.CharSequence,java.lang.Iterable))|
|length|[`len($EXPR$)`](https://pkg.go.dev/builtin#len)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.len)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#length())|
|repeat|[`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.repeat)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#repeat(int))|
|replaceAll|[`TODO`](TODO)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.replace)|[`TODO`](TODO)|
|split|[`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.split)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#split(java.lang.String))|
|startswith|[`strings.HasPrefix($EXPR$, pfx)`](https://pkg.go.dev/strings#HasPrefix)|[`$EXPR$.starts_with(pfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.starts_with)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#startsWith(java.lang.String))|
|toLower|[`strings.ToLower($EXPR$)`](https://pkg.go.dev/strings#ToLower)|[`$EXPR$.to_lowercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_lowercase)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toLowerCase())|
|toUpper|[`strings.ToUpper($EXPR$)`](https://pkg.go.dev/strings#ToUpper)|[`$EXPR$.to_uppercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_uppercase)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toUpperCase())|
|trim|[`strings.TrimSpace($EXPR$)`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim()`](https://doc.rust-lang.org/std/primitive.str.html#method.trim)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#trim())|


|`Operation`|[`Python`](https://www.python.org/)|[`Dart`](https://dart.dev/)|[`Ts`](https://www.typescriptlang.org/)|[`Kotlin`](https://kotlinlang.org/)|
|---|---|---|---|---|
|contains|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|endswith|[`TODO`](TODO)||[`TODO`](TODO)|[`TODO`](TODO)|
|equals|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|equalsIgnoreCase|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|isBlank|[`$EXPR$.strip() == ""`](https://docs.python.org/3/library/stdtypes.html#str.strip)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|isEmpty|[`$EXPR$ == ""`](https://docs.python.org/3/library/stdtypes.html#comparisons)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|join|[`TODO`](https://docs.python.org/3/library/stdtypes.html#str.join)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|length|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|repeat|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|replaceAll|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|split|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|startswith|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|toLower|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|toUpper|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|trim|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|


