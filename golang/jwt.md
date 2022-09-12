# Overview
- Candidate libs for [jwt](https://jwt.io/)


# Libs
## https://github.com/golang-jwt/jwt
1. Pro: Well documented
1. Pro: Actively Maintained
1. Pro: Easy to access standard claims (exp, iss, ...)
1. Pro: [Many examples](https://pkg.go.dev/github.com/golang-jwt/jwt/v4#pkg-examples)
1. Pro: Allows embedding standard claims into custom claims
1. Pro: [Dates](https://pkg.go.dev/github.com/golang-jwt/jwt/v4#NumericDate) are compatible with `time.Time`
1. Pro: Over 3,000 stars on Github
1. Pro: Protects against `alg=none` by default
1. Pro: Simple to handle Expired & NotYet cases
1. Pro: Sources reference https://datatracker.ietf.org
1. Pro: Support for arbitrary claims
1. Pro: Supports alternative clocks (time provider)
1. Con: No support for compact serialize

### Examples
1. [Sign](https://pkg.go.dev/github.com/golang-jwt/jwt/v4#example-NewWithClaims-CustomClaimsType)
1. [Verify/Parse](https://pkg.go.dev/github.com/golang-jwt/jwt/v4#example-ParseWithClaims-CustomClaimsType)


## https://pkg.go.dev/gopkg.in/square/go-jose.v2
1. Pro: support for arbitrary claims
1. Pro: support for compact serialize


## https://github.com/kataras/jwt
1. Pro: Actively Maintained
1. Pro: protects against `alg=none` by default
1. Pro: Supports alternative clocks (time provider)
1. Pro: well documented
1. Con: under 200 stars on Github


# Rejected
## https://github.com/gbrlsnchs/jwt
1. Con: Abandonware


# Idioms
1. Always select the algorithm to for parsing (don't let the token decide)


# Other resources
1. TODO ...
