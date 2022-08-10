# String Operations

|`Operation`|[`Go`](https://go.dev/)|[`Rust`](https://www.rust-lang.org/)|[`Java`](https://docs.oracle.com/javase/8/docs/technotes/guides/language/)|
|---|---|---|---|
|bytes|[`[]byte($EXPR$)`](TODO)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#getBytes())|
|charAt|[`$EXPR$[i:i+1] /* or */ `( []rune($EXPR$) )[3]``](TODO)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#charAt(int))|
|chars|[`range in  /* or */ []rune($EXPR$)`](TODO)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toCharArray())|
|compareTo|[`TODO`](https://pkg.go.dev/strings#Compare)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#compareTo(java.lang.String))|
|contains|[`strings.Contains($EXPR$, needle)`](https://pkg.go.dev/strings#Contains)|[`$EXPR$.contains(needle)`](https://doc.rust-lang.org/std/primitive.str.html#method.contains)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence))|
|endswith|[`strings.HasSuffix($EXPR$, sfx)`](https://pkg.go.dev/strings#HasSuffix)|[`$EXPR$.ends_with(sfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.ends_with)|[`$EXPR$.endsWith(sfx)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String))|
|equals|[`$EXPR$ == s2`](https://go.dev/ref/spec#Comparison_operators)|[`$EXPR$ == s2`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#tymethod.eq)|[`$EXPR$.equals(s2)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object))|
|equalsIgnoreCase|[`strings.EqualsFold($EXPR$, s2)`](https://pkg.go.dev/strings#EqualFold)|[`$EXPR$.eq_ignore_ascii_case(&s2)`](https://doc.rust-lang.org/std/primitive.str.html#method.eq_ignore_ascii_case)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String))|
|indexOf|[`strings.Index(haystack, needle)`](https://pkg.go.dev/strings#Index)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#indexOf(int))|
|isBlank|[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim().is_empty()`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank())|
|isEmpty|[`len($EXPR$) == 0`](https://pkg.go.dev/builtin#len)|[`$EXPR$ == s2`](https://doc.rust-lang.org/std/primitive.str.html#method.is_empty)|[`$EXPR$.isEmpty`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#isEmpty())|
|join|[`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join)|[`vec!["a", "b", "c"].join(sep);`](https://doc.rust-lang.org/std/primitive.slice.html#method.join)|[`String.join(" ", List.of("a", "b", "c"))`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#join(java.lang.CharSequence,java.lang.Iterable))|
|lastIndexOf|[`strings.LastIndex(haystack, needle)`](https://pkg.go.dev/strings#LastIndex)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#lastIndexOf(int))|
|length|[`len($EXPR$)`](https://pkg.go.dev/builtin#len)|[`$EXPR$.len()`](https://doc.rust-lang.org/std/primitive.str.html#method.len)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#length())|
|repeat|[`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat)|[`$EXPR$.repeat(n)`](https://doc.rust-lang.org/std/primitive.str.html#method.repeat)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#repeat(int))|
|replaceAll|[`strings.ReplaceAll(...)`](https://pkg.go.dev/strings#ReplaceAll)|[`$EXPR$.replace(old, new)`](https://doc.rust-lang.org/std/primitive.str.html#method.replace)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#replaceAll(java.lang.String,java.lang.String))|
|split|[`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split)|[`let v: Vec<_> = "$EXPR$".split(sep).collect();`](https://doc.rust-lang.org/std/primitive.str.html#method.split)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#split(java.lang.String))|
|startswith|[`strings.HasPrefix($EXPR$, pfx)`](https://pkg.go.dev/strings#HasPrefix)|[`$EXPR$.starts_with(pfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.starts_with)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#startsWith(java.lang.String))|
|substring|[`"abcde"[2:4] == "cd"`](TODO)|[`TODO`](TODO)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#substring(int,int))|
|toLower|[`strings.ToLower($EXPR$)`](https://pkg.go.dev/strings#ToLower)|[`$EXPR$.to_lowercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_lowercase)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toLowerCase())|
|toUpper|[`strings.ToUpper($EXPR$)`](https://pkg.go.dev/strings#ToUpper)|[`$EXPR$.to_uppercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_uppercase)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toUpperCase())|
|trim|[`strings.TrimSpace($EXPR$)`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim()`](https://doc.rust-lang.org/std/primitive.str.html#method.trim)|[`TODO`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#trim())|


|`Operation`|[`Python`](https://www.python.org/)|[`Dart`](https://dart.dev/)|[`Ts`](https://www.typescriptlang.org/)|[`Kotlin`](https://kotlinlang.org/)|
|---|---|---|---|---|
|bytes|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|charAt|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|chars|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|compareTo|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|contains|[`TODO`](TODO)|[`$EXPR$.contains(needle)`](https://api.dart.dev/stable/2.17.0/dart-core/String/contains.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|endswith|[`TODO`](TODO)|[`$EXPR$.endsWith(sfx)`](https://api.dart.dev/stable/2.17.0/dart-core/String/endsWith.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|equals|[`TODO`](TODO)|[`$EXPR$ == s2`](https://api.dart.dev/stable/2.17.6/dart-core/String/operator_equals.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|equalsIgnoreCase|[`TODO`](TODO)|[`$EXPR$.toLowerCase() == s2.toLowerCase()`](https://api.dart.dev/stable/2.17.6/dart-core/String/toLowerCase.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|indexOf|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|isBlank|[`$EXPR$.strip() == ""`](https://docs.python.org/3/library/stdtypes.html#str.strip)|[`$EXPR$.trim().isEmpty`](https://api.dart.dev/stable/2.17.6/dart-core/Iterable/isEmpty.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|isEmpty|[`$EXPR$ == ""`](https://docs.python.org/3/library/stdtypes.html#comparisons)|[`$EXPR$.isEmpty`](https://api.dart.dev/stable/2.17.6/dart-core/String/isEmpty.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|join|[`TODO`](https://docs.python.org/3/library/stdtypes.html#str.join)|[`$EXPR$.join(",")`](https://api.dart.dev/stable/2.17.6/dart-core/Iterable/join.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|lastIndexOf|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|[`TODO`](TODO)|
|length|[`TODO`](TODO)|[`$EXPR$.length`](https://api.dart.dev/stable/2.17.6/dart-core/String/length.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|repeat|[`TODO`](TODO)|[`$EXPR$ * n`](https://api.dart.dev/stable/2.17.6/dart-core/String/operator_multiply.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|replaceAll|[`TODO`](TODO)|[`$EXPR$.replaceAll(RegExp(r'ab'), new)`](https://api.dart.dev/stable/2.17.6/dart-core/String/replaceAll.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|split|[`TODO`](TODO)|[`$EXPR$.split(sep)`](https://api.dart.dev/stable/2.17.6/dart-core/String/split.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|startswith|[`TODO`](TODO)|[`$EXPR$.startsWith(pfx)`](https://api.dart.dev/stable/2.17.6/dart-core/String/startsWith.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|substring|[`TODO`](TODO)|[`TODO`](https://api.dart.dev/stable/2.17.6/dart-core/String/substring.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|toLower|[`TODO`](TODO)|[`$EXPR$.toLowerCase()`](https://api.dart.dev/stable/2.17.6/dart-core/String/toLowerCase.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|toUpper|[`TODO`](TODO)|[`$EXPR$.toUpperCase()`](https://api.dart.dev/stable/2.17.6/dart-core/String/toUpperCase.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|trim|[`TODO`](TODO)|[`$EXPR$.trim()`](https://api.dart.dev/stable/2.17.6/dart-core/String/trim.html)|[`TODO`](TODO)|[`TODO`](TODO)|


