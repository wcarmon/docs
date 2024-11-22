# Overview

1. How to Create, Sign & Verify a [jwt](https://jwt.io/)
1. Candidate libs for [jwt](https://jwt.io/)
    - Specifically: jsonwebtoken [rust docs](https://docs.rs/jsonwebtoken/latest/jsonwebtoken/), [github](https://github.com/Keats/jsonwebtoken]

# GOTCHA
1. JWT is heavily criticized
    1. https://paragonie.com/blog/2017/03/jwt-json-web-tokens-is-bad-standard-that-everyone-should-avoid
    1. http://cryto.net/~joepie91/blog/2016/06/13/stop-using-jwt-for-sessions/
1. Safe use patterns
    1. Never rely or even read the `alg` header passed in a token
    1. Only use symmetric key
    1. Only short-lived tokens
    1. Only single-use token


# Cargo.toml
```toml
[dependencies]
anyhow = "1"
chrono = "0.4"
jsonwebtoken = "9"
serde = {version = "1", features = ["derive"] }
```


# Config
```rust
    // -- Read from config
    let jwt_secret: &[u8] = "foo-bar".as_ref(); // use a password generator
    let algorithm = Algorithm::HS512;
    let token_life = Duration::minutes(45);
```


# Common structures
```rust
type EpochSeconds = i64;
type Email = String;

#[derive(Clone, Debug, Deserialize, Serialize)]
struct AuthClaims {
    exp: EpochSeconds,
    sub: Email,
}
```


# Create & Sign
```rust
    let email: Email = ...

    let exp_epoch_seconds = (Utc::now() + token_life).timestamp_millis() / 1000;
    let claims = AuthClaims {
        exp: exp_epoch_seconds,
        sub: email,
    };

    let token = encode(
        &Header::new(algorithm),
        &claims,
        &EncodingKey::from_secret(jwt_secret))?;

    // -- Send token back to user via REST, gRPC, WebSocket, etc
```


# Verify (Parse claims)

```rust
use jsonwebtoken::{decode, DecodingKey, Validation};

pub fn parse_claims(jwt: String) -> Result<AuthClaims, anyhow::Error> {
    ensure!(!jwt.trim().is_empty(), "JWT token required");

    let res = decode::<AuthClaims>(
        &jwt,
        &DecodingKey::from_secret(jwt_secret),
        &Validation::new(algorithm));

    if let Ok(parsed) = &res {
        return Ok(parsed.claims.clone());
    }

    let e = res.err().unwrap();
    if let ErrorKind::ExpiredSignature = e.kind() {
        // ... Handle expired token here
        // ... (eg. return a special error type)
        // ... Caller (Endpoint) can suggest a refresh to Client
        bail!("Expired token");
    }

    e.into()
}
```


# TODO: evaluate
- https://github.com/rib/jsonwebtokens
- https://github.com/jedisct1/rust-jwt-simple


# Rejected
1. ~~https://github.com/mikkyang/rust-jwt~~
    1. Nice, but seems abandoned
1. ~~https://github.com/jedisct1/rust-jwt-simple~~
    1. Con: lots of dependencies
1. ~~https://github.com/durch/rust-jwt~~

# Idioms

1. Always select the [algorithm](https://github.com/Keats/jsonwebtoken/blob/master/src/algorithms.rs#L16) on the server for parsing (don't allow the token decide)

# Other Resources

1. https://github.com/Keats/jsonwebtoken
