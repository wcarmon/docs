# Overview
1. How to generate random data


# Comparison to Java
1. [`rng.gen()`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen) uses [monomorphization](https://rustc-dev-guide.rust-lang.org/backend/monomorph.html) (reified type) to generate the correct thing (including tuples)
    1. or make type explicit: `rng.gen::<u32>()`, `rng.gen::<f64>()`
1. You can change from [Uniform Distribution](https://en.wikipedia.org/wiki/Continuous_uniform_distribution) to other [distributions](https://docs.rs/rand_distr/latest/rand_distr/index.html)

|Rust|Java|
|---|---|
|[`rng.gen_bool(0.5)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_bool)<br>or<br>`let b: bool = rng.gen()`|[`nextBoolean()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/Random.html#nextBoolean())|
|[`rng.gen_range(0..1000)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_range)<br>`let i: i32 = rng.gen()`|[`nextInt(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#nextInt(int,int))|
|[`rng.gen_range(0u64..50_000u64)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_range)<br>`let l: u64 = rng.gen()`|[`nextLong(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#nextLong(long,long))|
|[`rng.gen_range(0.0f64..1.0f64)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_range)|[`nextDouble()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#nextDouble(double,double))|
|[`rng.sample_iter(Uniform::from(1..7)).take(8).collect::<Vec<u16>>()`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.sample_iter)<br>`let v: BTreeSet<u16> = rng.sample_iter(Standard).take(8).collect();`|[`ints()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#ints(int,int))|
|[`rng.sample_iter(Uniform::from(500u64..1_000u64)).take(13).collect()`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.sample_iter)<br>`let v: Vec<u64> = rng.sample_iter(Standard).take(16).collect();`|[`longs()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#longs(long,long))|
|[`let v: Vec<f64> = rng.sample_iter(Uniform::from(0.0f64..1.0f64)).take(5).collect()`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.sample_iter)|[`doubles()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#doubles(double,double))|
|[`let mut rng = rand::thread_rng()`](https://docs.rs/rand/latest/rand/fn.thread_rng.html)|[`ThreadLocalRandom.current()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#current())|
|[`cksac/fake-rs`](https://crates.io/crates/fake)|[`DiUS/Faker`](https://github.com/DiUS/java-faker)|


# Fake data

```rust
use fake::faker::internet::en::SafeEmail;
use fake::faker::lorem::en::*;
use fake::faker::phone_number::en::PhoneNumber;
use fake::locales::EN;
use fake::{Fake, Faker};

// ...

    let mut rng = rand::thread_rng();
```

|Data Type|Generate|
|---|---|
|[`bool`](https://doc.rust-lang.org/std/primitive.bool.html)|`rng.gen_bool(0.5)`|
|[`chrono::DateTime<Utc>`](TODO)|`TODO`|
|[`chrono::NaiveDate`](TODO)|`TODO`|
|[`chrono::NaiveTime`](TODO)|`TODO`|
|[`f32`](TODO)|`TODO`|
|[`f64`](TODO)|`TODO`|
|[`HashSet<f64>`](TODO)|`TODO`|
|[`HashSet<i64>`](TODO)|`TODO`|
|[`HashSet<String>`](TODO)|`TODO`|
|[`HashSet<u64>`](TODO)|`TODO`|
|[`rust_decimal::Decimal`](TODO)|`TODO`|
|[email](https://en.wikipedia.org/wiki/Email_address)|`SafeEmail().fake()`|
|[uuid](https://docs.rs/uuid/latest/uuid/)|`uuid::Uuid::new_v4()`|
|`i128`|`TODO`|
|`i16`|`TODO`|
|`i32`|`TODO`|
|`i64`|`TODO`|
|`i8`|`TODO`|
|`Option<f64>`|`TODO`|
|`Option<i64>`|`TODO`|
|`Option<u64>`|`TODO`|
|`PathBuf`|`TODO`|
|`u128`|`TODO`|
|`u16`|`TODO`|
|`u32`|`TODO`|
|`u8`|`TODO`|
|`Vec<char>`|`TODO`|
|`Vec<f64>`|`TODO`|
|`Vec<i64>`|`TODO`|
|`Vec<u64>`|`TODO`|
|`Vec<u8>`|`TODO`|
|Human Name|`Name(EN).fake()`|
|Words|`Words(0..max_items).fake::<Vec<String>>().into_iter().collect()`|
|~~`std::time::SystemTime`~~ (prefer `chrono::DateTime<Utc>`)||
|TCP Port|`TODO`|
|u64|`TODO`|
|`String` with specific chars|`TODO`|
|TODO|`TODO`|



# Other Resources
1. https://rust-lang-nursery.github.io/rust-cookbook/algorithms/randomness.html
1. https://docs.rs/rand_distr/latest/rand_distr/struct.Uniform.html