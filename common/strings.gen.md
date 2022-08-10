# String Operations

|`Operation`|[`Go`](https://go.dev/)|[`Rust`](https://www.rust-lang.org/)|[`Java`](https://docs.oracle.com/javase/8/docs/technotes/guides/language/)|[`Kotlin`](https://kotlinlang.org/)|
|---|---|---|---|---|
|contains|[`strings.Contains($EXPR$, needle)`](https://pkg.go.dev/strings#Contains)|[`$EXPR$.contains(needle)`](https://doc.rust-lang.org/std/primitive.str.html#method.contains)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence))|[`TODO`](TODO)|
|endswith|[`strings.HasSuffix($EXPR$, sfx)`](https://pkg.go.dev/strings#HasSuffix)|[`$EXPR$.ends_with(sfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.ends_with)|[`$EXPR$.endsWith(sfx)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String))|[`TODO`](TODO)|
|equals|[`$EXPR$ == s2`](https://go.dev/ref/spec#Comparison_operators)|[`$EXPR$ == s2`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#tymethod.eq)|[`$EXPR$.equals(s2)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object))|[`TODO`](TODO)|
|equalsIgnoreCase|[`strings.EqualsFold($EXPR$, s2)`](https://pkg.go.dev/strings#EqualFold)|[`$EXPR$.eq_ignore_ascii_case(&s2)`](https://doc.rust-lang.org/std/primitive.str.html#method.eq_ignore_ascii_case)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String))|[`TODO`](TODO)|
|isBlank|[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim().is_empty()`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank())|[`TODO`](TODO)|
|isEmpty|[`len($EXPR$) == 0`](https://pkg.go.dev/builtin#len)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.is_empty)|[`$EXPR$.isEmpty`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#isEmpty())|[`TODO`](TODO)|
|join|[`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join)|[`vec!["a", "b", "c"].join(sep);`](https://doc.rust-lang.org/std/primitive.slice.html#method.join)|[`String.join(" ", List.of("a", "b", "c"))`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#join(java.lang.CharSequence,java.lang.Iterable))|[`TODO`](TODO)|
|length|[`len($EXPR$)`](https://pkg.go.dev/builtin#len)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.len)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#length())|[`TODO`](TODO)|
|repeat|[`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.repeat)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#repeat(int))|[`TODO`](TODO)|
|replaceAll|[`TODO`](TODO)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.replace)|[`TODO`](TODO)|[`TODO`](TODO)|
|split|[`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split)|[`TODO`](https://doc.rust-lang.org/std/primitive.str.html#method.split)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#split(java.lang.String))|[`TODO`](TODO)|
|startswith|[`strings.HasPrefix($EXPR$, pfx)`](https://pkg.go.dev/strings#HasPrefix)|[`$EXPR$.starts_with(pfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.starts_with)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#startsWith(java.lang.String))|[`TODO`](TODO)|
|toLower|[`strings.ToLower($EXPR$)`](https://pkg.go.dev/strings#ToLower)|[`$EXPR$.to_lowercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_lowercase)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toLowerCase())|[`TODO`](TODO)|
|toUpper|[`strings.ToUpper($EXPR$)`](https://pkg.go.dev/strings#ToUpper)|[`$EXPR$.to_uppercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_uppercase)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toUpperCase())|[`TODO`](TODO)|
|trim|[`strings.TrimSpace($EXPR$)`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim()`](https://doc.rust-lang.org/std/primitive.str.html#method.trim)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#trim())|[`TODO`](TODO)|


|`Operation`|[`Dart`](https://dart.dev/)|[`Python`](https://www.python.org/)|[`Ts`](https://www.typescriptlang.org/)|
|---|---|---|---|
|contains|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|endswith||[`TODO`](TODO)|[`TODO`](TODO)|
|equals|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|equalsIgnoreCase|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|isBlank|[`TODO`](TODO)|[`$EXPR$.strip() == ""`](https://docs.python.org/3/library/stdtypes.html#str.strip)|[`TODO`](TODO)|
|isEmpty|[`TODO`](TODO)|[`$EXPR$ == ""`](https://docs.python.org/3/library/stdtypes.html#comparisons)|[`TODO`](TODO)|
|join|[`TODO`](TODO)|[`TODO`](https://docs.python.org/3/library/stdtypes.html#str.join)|[`TODO`](TODO)|
|length|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|repeat|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|replaceAll|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|split|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|startswith|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|toLower|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|toUpper|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|trim|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|


