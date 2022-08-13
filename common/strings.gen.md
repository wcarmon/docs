# String Operations

|`Operation`|[`Go`](https://go.dev/)|[`Rust`](https://www.rust-lang.org/)|[`Java`](https://docs.oracle.com/javase/8/docs/technotes/guides/language/)|
|---|---|---|---|
|bytes|`[]byte($EXPR$)`|`$EXPR$.as_bytes()`|`$EXPR$.getBytes("UTF8")`|
|charAt|`$EXPR$[i:i+1] /* or */ ( []rune($EXPR$) )[3]`|`$EXPR$.chars().nth(3)`|`$EXPR$.charAt(3)`|
|chars|`range in $EXPR$ /* or */ []rune($EXPR$)`|`$EXPR$.chars()`|`$EXPR$.toCharArray()`|
|compareTo|`strings.Compare($EXPR$, s2)`|`$EXPR$.cmp(s2) == Ordering::Less`|`$EXPR$.compareTo(s2)`|
|contains|`strings.Contains($EXPR$, needle)`|`$EXPR$.contains(needle)`|`$EXPR$.contains(needle)`|
|eic,equalsIgnoreCase|`strings.EqualsFold($EXPR$, s2)`|`$EXPR$.eq_ignore_ascii_case(&s2)`|`$EXPR$.equalsIgnoreCase(s2)`|
|endsWith|`strings.HasSuffix($EXPR$, sfx)`|`$EXPR$.ends_with(sfx)`|`$EXPR$.endsWith(sfx)`|
|equals|`$EXPR$ == s2`|`$EXPR$ == s2`|`$EXPR$.equals(s2)`|
|indexOf|`strings.Index(haystack, needle)`|`$EXPR$.find(needle)`|`$EXPR$.indexOf(needle)`|
|isBlank|`strings.TrimSpace(s) == ""`|`$EXPR$.trim() == ""`|`$EXPR$.isBlank()`|
|isEmpty|`len($EXPR$) == 0`|`$EXPR$ == s2`|`$EXPR$.isEmpty`|
|join|`strings.Join(slice, sep)`|`vec!["a", "b", "c"].join(sep)`|`String.join(sep, List.of("a", "b", "c"))`|
|lastIndexOf|`strings.LastIndex(haystack, needle)`|`$EXPR$.rfind(needle)`|`$EXPR$.lastIndexOf(needle)`|
|length|`len($EXPR$)`|`$EXPR$.len()`|`$EXPR$.length()`|
|repeat|`strings.Repeat(s, n)`|`$EXPR$.repeat(n)`|`$EXPR$.repeat(n)`|
|replaceAll|`strings.ReplaceAll($EXPR$, old, new)`|`$EXPR$.replace(old, new)`|`$EXPR$.replaceAll(old, new)`|
|split|`strings.Split($EXPR$, sep)`|`let v: Vec<_> = "$EXPR$".split(sep).collect()`|`$EXPR$.split(sep, 0)`|
|startsWith|`strings.HasPrefix($EXPR$, pfx)`|`$EXPR$.starts_with(pfx)`|`$EXPR$.startsWith(pfx)`|
|strip,trim,TrimSpace|`strings.TrimSpace($EXPR$)`|`$EXPR$.trim()`|`$EXPR$.strip()`|
|substring|`"abcde"[2:4] == "cd"`|`&"abcde"[2..4] == "cd"`|`"abcde".substring(2, 4).equals("cd")`|
|toLower|`strings.ToLower($EXPR$)`|`$EXPR$.to_lowercase()`|`$EXPR$.toLowerCase(Locale.ROOT)`|
|toUpper,touppercase,upper|`strings.ToUpper($EXPR$)`|`$EXPR$.to_uppercase()`|`$EXPR$.toUpperCase(Locale.ROOT)`|


|`Operation`|[`Python`](https://www.python.org/)|[`Dart`](https://dart.dev/)|[`Ts`](https://www.typescriptlang.org/)|
|---|---|---|---|
|bytes|`$EXPR$.encode()`|`$EXPR$.runes`|`new TextEncoder().encode($EXPR$)`|
|charAt|`$EXPR$[3]`|`$EXPR$[3]`|`$EXPR$[3]`|
|chars|`list($EXPR$)`|`$EXPR$.split('')`|`$EXPR$.split('')`|
|compareTo|`$EXPR$ < s2`|`$EXPR$.compareTo(s2)`|`$EXPR$.localeCompare(s2)`|
|contains|`needle in $EXPR$`|`$EXPR$.contains(needle)`|`$EXPR$.indexOf(needle) > -1`|
|eic,equalsIgnoreCase|`$EXPR$.casefold() == s2.casefold()`|`$EXPR$.toUpperCase() == s2.toUpperCase()`|`$EXPR$.toUpperCase() === s2.toUpperCase()`|
|endsWith|`$EXPR$.endswith(sfx)`|`$EXPR$.endsWith(sfx)`|`$EXPR$.endsWith(sfx)`|
|equals|`$EXPR$ == s2`|`$EXPR$ == s2`|`$EXPR$ === s2`|
|indexOf|`$EXPR$.find(needle)`|`$EXPR$.indexOf(needle)`|`$EXPR$.indexOf(needle)`|
|isBlank|`$EXPR$.strip() == ""`|`$EXPR$.trim().isEmpty`|`$EXPR$.trim() === ""`|
|isEmpty|`$EXPR$ == ""`|`$EXPR$.isEmpty`|`$EXPR$ === ""`|
|join|`",".join(["a", "b", "c"])`|`$EXPR$.join(",")`|`["a", "b", "c"].join(sep)`|
|lastIndexOf|`$EXPR$.rfind(needle)`|`$EXPR$.lastIndexOf(needle)`|`$EXPR$.lastIndexOf(needle)`|
|length|`len($EXPR$)`|`$EXPR$.length`|`$EXPR$.length`|
|repeat|`$EXPR$ * n`|`$EXPR$ * n`|`$EXPR$.repeat(n)`|
|replaceAll|`$EXPR$.replace(old, new, -1)`|`$EXPR$.replaceAll(RegExp(r'ab'), new)`|`$EXPR$.replaceAll(old, new)`|
|split|`$EXPR$.split(sep)`|`$EXPR$.split(sep)`|`$EXPR$.split(sep)`|
|startsWith|`$EXPR$.startswith(pfx)`|`$EXPR$.startsWith(pfx)`|`$EXPR$.startsWith(pfx)`|
|strip,trim,TrimSpace|`$EXPR$.strip()`|`$EXPR$.trim()`|`$EXPR$.trim()`|
|substring|`"abcde"[2:4] == "cd"`|`$EXPR$.substring(start, end)`|`"abcde".substring(2,4) === "cd"`|
|toLower|`$EXPR$.lower()`|`$EXPR$.toLowerCase()`|`$EXPR$.toLowerCase()`|
|toUpper,touppercase,upper|`$EXPR$.upper()`|`$EXPR$.toUpperCase()`|`$EXPR$.toUpperCase()`|


|`Operation`|[`Bash`](https://www.gnu.org/software/bash/)|[`Ash`](https://en.wikipedia.org/wiki/Almquist_shell)|[`Kotlin`](https://kotlinlang.org/)|
|---|---|---|---|
|bytes|`TODO`|`TODO`|`TODO`|
|charAt|`IN='abc'; OUT=${IN:2:1}`|`IN='abc'; OUT=${IN:2:1}`|`TODO`|
|chars|`TODO`|`TODO`|`TODO`|
|compareTo|`TODO`|`TODO`|`TODO`|
|contains|`TODO`|`TODO`|`TODO`|
|eic,equalsIgnoreCase|`TODO`|`TODO`|`TODO`|
|endsWith|`IN='abc'; if [[ $IN =~ c$ ]]; then echo 'yes'; fi`|`IN='abc'; if [[ $IN =~ c$ ]]; then echo 'yes'; fi`|`TODO`|
|equals|`if [ "a" = "a" ]; then echo 'yes'; fi;`|`if [ "a" = "a" ]; then echo 'yes'; fi;`|`TODO`|
|indexOf|`TODO`|`TODO`|`TODO`|
|isBlank|`IN=' '; if [ "$(echo $IN)" = "" ]; then echo 'yes'; fi;`|`IN=' '; if [ "$(echo $IN)" = "" ]; then echo 'yes'; fi;`|`TODO`|
|isEmpty|`IN=''; if [ "$IN" = "" ]; then echo 'yes'; fi;`|`IN=''; if [ "$IN" = "" ]; then echo 'yes'; fi;`|`TODO`|
|join|`TODO`|`TODO`|`TODO`|
|lastIndexOf|`TODO`|`TODO`|`TODO`|
|length|`IN="foo"; OUT=${#IN}`|`IN="foo"; OUT=${#IN}`|`TODO`|
|repeat|`IN='z'; CNT=5; OUT=$(echo $(for i in $(seq 1 $CNT); do printf $IN; done))`|`IN='z'; CNT=5; OUT=$(echo $(for i in $(seq 1 $CNT); do printf $IN; done))`|`TODO`|
|replaceAll|`TODO`|`TODO`|`TODO`|
|split|`TODO`|`TODO`|`TODO`|
|startsWith|`IN='abc'; if [[ $IN =~ ^ab ]]; then echo 'yes'; fi`|`IN='abc'; if [[ $IN =~ ^ab ]]; then echo 'yes'; fi`|`TODO`|
|strip,trim,TrimSpace|`IN=' foo '; OUT=$(echo $IN)`|`IN=' foo '; OUT=$(echo $IN)`|`TODO`|
|substring|`TODO`|`TODO`|`TODO`|
|toLower|`IN='FOO'; OUT=$(echo $IN \| tr '[:upper:]' '[:lower:]')`|`IN='FOO'; OUT=$(echo $IN \| tr '[:upper:]' '[:lower:]')`|`TODO`|
|toUpper,touppercase,upper|`IN='foo'; OUT=$(echo $IN \| tr '[:lower:]' '[:upper:]')`|`IN='foo'; OUT=$(echo $IN \| tr '[:lower:]' '[:upper:]')`|`TODO`|


