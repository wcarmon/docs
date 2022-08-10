# String Operations

|`Operation`|[`Go`](https://go.dev/)|[`Rust`](https://www.rust-lang.org/)|[`Java`](https://docs.oracle.com/javase/8/docs/technotes/guides/language/)|
|---|---|---|---|
|bytes|[`[]byte($EXPR$)`](TODO)|[`$EXPR$.as_bytes()`](https://doc.rust-lang.org/std/string/struct.String.html#method.as_bytes)|[`$EXPR$.getBytes("UTF8")`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#getBytes(java.lang.String))|
|charAt|`$EXPR$[i:i+1] /* or */ ( []rune($EXPR$) )[3]`|[`$EXPR$.chars().nth(3)`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.nth)|[`$EXPR$.charAt(3)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#charAt(int))|
|chars|[`range in  /* or */ []rune($EXPR$)`](TODO)|[`$EXPR$.chars()`](https://doc.rust-lang.org/std/primitive.str.html#method.chars)|[`$EXPR$.toCharArray()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toCharArray())|
|compareTo|[`TODO`](https://pkg.go.dev/strings#Compare)|[`$EXPR$.cmp(s2) == Ordering::Less`](https://doc.rust-lang.org/std/cmp/trait.Ord.html#tymethod.cmp)|[`$EXPR$.compareTo(s2)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#compareTo(java.lang.String))|
|contains|[`strings.Contains($EXPR$, needle)`](https://pkg.go.dev/strings#Contains)|[`$EXPR$.contains(needle)`](https://doc.rust-lang.org/std/primitive.str.html#method.contains)|[`$EXPR$.contains(needle)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#contains(java.lang.CharSequence))|
|endswith|[`strings.HasSuffix($EXPR$, sfx)`](https://pkg.go.dev/strings#HasSuffix)|[`$EXPR$.ends_with(sfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.ends_with)|[`$EXPR$.endsWith(sfx)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#endsWith(java.lang.String))|
|equals|[`$EXPR$ == s2`](https://go.dev/ref/spec#Comparison_operators)|[`$EXPR$ == s2`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html#tymethod.eq)|[`$EXPR$.equals(s2)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equals(java.lang.Object))|
|equalsIgnoreCase|[`strings.EqualsFold($EXPR$, s2)`](https://pkg.go.dev/strings#EqualFold)|[`$EXPR$.eq_ignore_ascii_case(&s2)`](https://doc.rust-lang.org/std/primitive.str.html#method.eq_ignore_ascii_case)|[`$EXPR$.equalsIgnoreCase(s2)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#equalsIgnoreCase(java.lang.String))|
|indexOf|[`strings.Index(haystack, needle)`](https://pkg.go.dev/strings#Index)|[`$EXPR$.find(needle)`](https://doc.rust-lang.org/std/string/struct.String.html#method.find)|[`$EXPR$.indexOf(needle)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#indexOf(int))|
|isBlank|[`strings.TrimSpace(s) == ""`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim().is_empty()`](TODO)|[`$EXPR$.isBlank()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#isBlank())|
|isEmpty|[`len($EXPR$) == 0`](https://pkg.go.dev/builtin#len)|[`$EXPR$ == s2`](https://doc.rust-lang.org/std/primitive.str.html#method.is_empty)|[`$EXPR$.isEmpty`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#isEmpty())|
|join|[`strings.Join(slice, sep)`](https://pkg.go.dev/strings#Join)|[`vec!["a", "b", "c"].join(sep);`](https://doc.rust-lang.org/std/primitive.slice.html#method.join)|[`String.join(" ", List.of("a", "b", "c"))`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#join(java.lang.CharSequence,java.lang.Iterable))|
|lastIndexOf|[`strings.LastIndex(haystack, needle)`](https://pkg.go.dev/strings#LastIndex)|[`$EXPR$.rfind(needle)`](https://doc.rust-lang.org/std/string/struct.String.html#method.rfind)|[`$EXPR$.lastIndexOf(needle)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#lastIndexOf(int))|
|length|[`len($EXPR$)`](https://pkg.go.dev/builtin#len)|[`$EXPR$.len()`](https://doc.rust-lang.org/std/primitive.str.html#method.len)|[`$EXPR$.length()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#length())|
|repeat|[`strings.Repeat(s, n)`](https://pkg.go.dev/strings#Repeat)|[`$EXPR$.repeat(n)`](https://doc.rust-lang.org/std/primitive.str.html#method.repeat)|[`$EXPR$.repeat(n)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#repeat(int))|
|replaceAll|[`strings.ReplaceAll($EXPR$, old, new)`](https://pkg.go.dev/strings#ReplaceAll)|[`$EXPR$.replace(old, new)`](https://doc.rust-lang.org/std/primitive.str.html#method.replace)|[`$EXPR$.replaceAll(old, new)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#replaceAll(java.lang.String,java.lang.String))|
|split|[`strings.Split(s, sep)`](https://pkg.go.dev/strings#Split)|[`let v: Vec<_> = "$EXPR$".split(sep).collect();`](https://doc.rust-lang.org/std/primitive.str.html#method.split)|[`$EXPR$.split(sep, 0)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#split(java.lang.String))|
|startswith|[`strings.HasPrefix($EXPR$, pfx)`](https://pkg.go.dev/strings#HasPrefix)|[`$EXPR$.starts_with(pfx)`](https://doc.rust-lang.org/std/primitive.str.html#method.starts_with)|[`$EXPR$.startsWith(pfx)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#startsWith(java.lang.String))|
|substring|[`"abcde"[2:4] == "cd"`](TODO)|[`&"abcde"[2..4]`](https://doc.rust-lang.org/nightly/book/ch08-02-strings.html#slicing-strings)|[`"abcde".substring(2, 4)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#substring(int,int))|
|toLower|[`strings.ToLower($EXPR$)`](https://pkg.go.dev/strings#ToLower)|[`$EXPR$.to_lowercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_lowercase)|[`$EXPR$.toLowerCase(Locale.ROOT)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toLowerCase())|
|toUpper|[`strings.ToUpper($EXPR$)`](https://pkg.go.dev/strings#ToUpper)|[`$EXPR$.to_uppercase()`](https://doc.rust-lang.org/std/primitive.str.html#method.to_uppercase)|[`$EXPR$.toUpperCase(Locale.ROOT)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html#toUpperCase())|
|trim|[`strings.TrimSpace($EXPR$)`](https://pkg.go.dev/strings#TrimSpace)|[`$EXPR$.trim()`](https://doc.rust-lang.org/std/primitive.str.html#method.trim)|[`$EXPR$.strip()`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#strip())|


|`Operation`|[`Python`](https://www.python.org/)|[`Dart`](https://dart.dev/)|[`Ts`](https://www.typescriptlang.org/)|[`Kotlin`](https://kotlinlang.org/)|
|---|---|---|---|---|
|bytes|[`TODO`](TODO)|[`$EXPR$.runes`](https://api.dart.dev/stable/2.17.6/dart-core/String/runes.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|charAt|[`TODO`](TODO)|`$EXPR$[3]`|[`TODO`](TODO)|[`TODO`](TODO)|
|chars|[`TODO`](TODO)|[`$EXPR$.split('')`](https://api.flutter.dev/flutter/dart-core/String/split.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|compareTo|[`TODO`](TODO)|[`$EXPR$.compareTo(s2)`](https://api.flutter.dev/flutter/dart-core/String/compareTo.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|contains|[`TODO`](TODO)|[`$EXPR$.contains(needle)`](https://api.dart.dev/stable/2.17.0/dart-core/String/contains.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|endswith|[`TODO`](TODO)|[`$EXPR$.endsWith(sfx)`](https://api.dart.dev/stable/2.17.0/dart-core/String/endsWith.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|equals|[`TODO`](TODO)|[`$EXPR$ == s2`](https://api.dart.dev/stable/2.17.6/dart-core/String/operator_equals.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|equalsIgnoreCase|[`TODO`](TODO)|[`$EXPR$.toLowerCase() == s2.toLowerCase()`](https://api.dart.dev/stable/2.17.6/dart-core/String/toLowerCase.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|indexOf|[`TODO`](TODO)|[`$EXPR$.indexOf(needle)`](https://api.dart.dev/be/181224/dart-core/String/indexOf.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|isBlank|[`$EXPR$.strip() == ""`](https://docs.python.org/3/library/stdtypes.html#str.strip)|[`$EXPR$.trim().isEmpty`](https://api.dart.dev/stable/2.17.6/dart-core/Iterable/isEmpty.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|isEmpty|[`$EXPR$ == ""`](https://docs.python.org/3/library/stdtypes.html#comparisons)|[`$EXPR$.isEmpty`](https://api.dart.dev/stable/2.17.6/dart-core/String/isEmpty.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|join|[`TODO`](https://docs.python.org/3/library/stdtypes.html#str.join)|[`$EXPR$.join(",")`](https://api.dart.dev/stable/2.17.6/dart-core/Iterable/join.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|lastIndexOf|[`TODO`](TODO)|[`$EXPR$.lastIndexOf(needle)`](https://api.dart.dev/stable/2.17.6/dart-core/String/lastIndexOf.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|length|[`TODO`](TODO)|[`$EXPR$.length`](https://api.dart.dev/stable/2.17.6/dart-core/String/length.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|repeat|[`TODO`](TODO)|[`$EXPR$ * n`](https://api.dart.dev/stable/2.17.6/dart-core/String/operator_multiply.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|replaceAll|[`TODO`](TODO)|[`$EXPR$.replaceAll(RegExp(r'ab'), new)`](https://api.dart.dev/stable/2.17.6/dart-core/String/replaceAll.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|split|[`TODO`](TODO)|[`$EXPR$.split(sep)`](https://api.dart.dev/stable/2.17.6/dart-core/String/split.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|startswith|[`TODO`](TODO)|[`$EXPR$.startsWith(pfx)`](https://api.dart.dev/stable/2.17.6/dart-core/String/startsWith.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|substring|[`TODO`](TODO)|[`$EXPR$.substring(start, end)`](https://api.dart.dev/stable/2.17.6/dart-core/String/substring.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|toLower|[`TODO`](TODO)|[`$EXPR$.toLowerCase()`](https://api.dart.dev/stable/2.17.6/dart-core/String/toLowerCase.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|toUpper|[`TODO`](TODO)|[`$EXPR$.toUpperCase()`](https://api.dart.dev/stable/2.17.6/dart-core/String/toUpperCase.html)|[`TODO`](TODO)|[`TODO`](TODO)|
|trim|[`TODO`](TODO)|[`$EXPR$.trim()`](https://api.dart.dev/stable/2.17.6/dart-core/String/trim.html)|[`TODO`](TODO)|[`TODO`](TODO)|


