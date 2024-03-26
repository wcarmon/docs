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
|[`rng.sample_iter(Uniform::from(1..7)).take(8).collect::<Vec<u16>>()`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.sample_iter)<br>`let values: BTreeSet<u16> = rng.sample_iter(Standard).take(8).collect();`|[`ints()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#ints(int,int))|
|[`rng.sample_iter(Uniform::from(500u64..1_000u64)).take(13).collect()`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.sample_iter)<br>`let values: Vec<u64> = rng.sample_iter(Standard).take(16).collect();`|[`longs()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#longs(long,long))|
|[`let values: Vec<f64> = rng.sample_iter(Uniform::from(0.0f64..1.0f64)).take(5).collect()`](https://rust-random.github.io/rand/rand/trait.Rng.html#method.sample_iter)|[`doubles()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#doubles(double,double))|
|[`let mut rng = rand::thread_rng()`](https://docs.rs/rand/latest/rand/fn.thread_rng.html)|[`var rng = ThreadLocalRandom.current()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#current())|
|[`cksac/fake-rs`](https://crates.io/crates/fake)|[`DiUS/Faker`](https://github.com/DiUS/java-faker)|
|[``](TODO)|[``](TODO)|


# Other resources
1. https://rust-lang-nursery.github.io/rust-cookbook/algorithms/randomness.html
1. https://docs.rs/rand_distr/latest/rand_distr/struct.Uniform.html