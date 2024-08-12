# Overview
1. How to use [argon2](https://en.wikipedia.org/wiki/Argon2) in rust
    - Specifically: https://crates.io/crates/rust-argon2

# Cargo.toml
```toml
[dependencies]
anyhow = "1"
rust-argon2 = "2"
```


# Encrypt
- Set password for a user
```rust
    let desired_password = "...".as_bytes();
    // let desired_password = b"...";  // if you already have a &[u8]

    let argon_config = Config::default();

    // -- See https://en.wikipedia.org/wiki/Salt_(cryptography)
    let salt_len = thread_rng().gen_range(16..32);
    let salt = gen_random_string(salt_len).as_bytes();

    let argon_hash = argon2::hash_encoded(
        desired_password,
        salt,
        &argon_config)
        .context("failed to hash password")?;

    // ... store argon_hash in database
```


# Example `users` Table
```sql
-- Postgres
CREATE TABLE auth.users
(
    uuid                 VARCHAR(36) PRIMARY KEY,
    email                VARCHAR(96) UNIQUE NOT NULL,
    created_epoch_millis BIGINT             NOT NULL,
    updated_epoch_millis BIGINT             NOT NULL,

    -- argon2 hash is between 83 and 117 chars
    --
    -- Salt:
    --  - for argon2, salt is embedded (at the end)
    --  - salt length between 8 and 4_294_967_295 chars
    --
    -- Alternatively, can use blob or bytea
    password_hash        VARCHAR(176)       NOT NULL,

    -- Table constraints go here
)
```


# Verify Password
```rust
    // -- Read candidate password from HTTP/gRPC request
    let password_str: String = "..."; // read from HTTP request
    let password_bytes: &[u8] = password_str.as_bytes();
    // let password_bytes: &[u8] = b"..."; // or just read bytes directly

    // -- Same config (or compatible with config) used for building the hash
    let argon_config = Config::default();

    let hash_in_database: String = <read hash from database>;

    // -- Intentionally slow, determine if password matches
    let password_matches = argon2::verify_encoded(
        &hash_in_database, password_bytes)
        .context("failed to verify password")?;

    if password_matches {
        // Handle match (eg. build JWT, redirect, etc)

    } else {
        // Handle mismatch (eg. return error response)
    }
```


# Other Resources
1. https://docs.rs/rust-argon2/latest/argon2/
1. https://www.password-hashing.net/
