# Overview
1. Common idioms for regular expressions
1. Notation for describing sets of char strings
1. "sql for text"


# Key points
1. Guaranteed to run in linear time (unlike regex in many other languages)
1. Unlike javascript, regular expressions **are reusable**
1. Threadsafe (safe for use by multiple goroutines) [Proof](https://pkg.go.dev/regexp#Regexp)
1. Backreferences can be computationally expensive (eg. exponential time)


# Create regex
1. [`Compile`](https://pkg.go.dev/regexp#Compile) builds optimized regex struct
1. Use a [raw string](https://go.dev/ref/spec#String_literals) to avoid issues with backslashes
    1. back slashes have no "special" meaning in a raw string, so no extra escapes are required
1. Example
```go
r, err := regexp.Compile(`[a-z]`)
if err != nil {
    return err
}

...
```

## Golang Regex Syntax
1. [RE2 syntax](https://github.com/google/re2/wiki/Syntax)
    1. More info: [here](https://pkg.go.dev/regexp/syntax) and [here](https://www.sibis.dev/regex-in-golang)


# Golang Regex API
1. Methods available on a [regex](https://pkg.go.dev/regexp#Regexp) follow this pattern: [`Find(All)?(String)?(Submatch)?(Index)?`](https://pkg.go.dev/regexp#pkg-overview)
- `All`: matches successive non-overlapping
- `String`: `string` vs `[]byte`
- **`Submatch`**: include capturing groups, meaning parenthesized subexpressions: `(...)`
- `Index`: return character indexes for matches (instead of `string`/`[]byte`)


# Find matches
1. [r.FindAllString](https://pkg.go.dev/regexp#Regexp.FindAllString)
    1. `-1` for second argument returns all matches.
    1. More examples: [harrietty](https://gist.github.com/harrietty/d737a350827e100712c5b62168358c88#return-all-match-strings)
    1. returns **empty slice** when zero matches (`len(output) == 0`)
1. [r.FindAllStringSubmatch](https://pkg.go.dev/regexp#Regexp.FindAllStringSubmatch)
    1. Includes [capture groups](https://www.regular-expressions.info/brackets.html)
    1. returns **empty slice** when zero matches (`len(output) == 0`)


# Test for matches
1. [r.MatchString](https://pkg.go.dev/regexp#Regexp.MatchString)


# Replacement
1. [r.ReplaceAllString](https://pkg.go.dev/regexp#Regexp.ReplaceAllString)
1. [r.ReplaceAllStringFunc](https://pkg.go.dev/regexp#Regexp.ReplaceAllStringFunc)
    1. Allows `func(string) string` to transform, eg. `strings.ToUpper`

# Split
1. separated by the expression (delim)
1. returns substrings **between** the matches
1. [r.Split](https://pkg.go.dev/regexp#Regexp.Split)


# Idioms
TODO ...



# Other resources
1. https://pkg.go.dev/regexp
1. https://pkg.go.dev/regexp/syntax
1. https://github.com/google/re2/wiki/Syntax
1. https://regex101.com/
1. https://regexr.com/
1. https://yourbasic.org/golang/regexp-cheat-sheet/
1. https://gist.github.com/harrietty/d737a350827e100712c5b62168358c88
1. https://www.jetbrains.com/help/go/code-inspections-in-regexp.html
