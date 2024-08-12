# Overview

1. How to Create, Sign & verify a jwt
1. Candidate libs for [jwt](https://jwt.io/)
    - Specifically: https://docs.rs/jsonwebtoken/latest/jsonwebtoken/


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
    let jwt_secret: &[u8] = "foo-bar".as_ref(); // use a UUID or something
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

    let header = Header::new(algorithm);
    let token = encode(&header, &claims, &EncodingKey::from_secret(jwt_secret))?;

    // -- Send token back to user via REST, gRPC, WebSocket, etc
```


# Verify (Parse claims)

```rust
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
            // ... handle expired token here (eg. return a special error type)
            // ... eg. suggest a refresh
            bail!("Expired token");
        }

        Err(e.into())
    }


```

# Rejected

1. ~~https://github.com/jedisct1/rust-jwt-simple~~
    1. Con: lots of dependencies
1. ~~https://github.com/durch/rust-jwt~~

# Idioms

1. Always select the algorithm for parsing (don't let the token decide)

# Other Resources

1. https://github.com/Keats/jsonwebtoken
1. https://github.com/mikkyang/rust-jwt
