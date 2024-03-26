# Overview
1. How to generate random data


# Comparison to Java
1. [`rng.gen()`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen) uses TODO (reified type) to generate the correct thing (including tuples)

|Rust|Java|
|---|---|
|[`rng.gen_bool(0.5)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_bool)<br>or<br>`let b: bool = rng.gen()`|[`nextBoolean()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/Random.html#nextBoolean())|
|[`rng.gen_range(0..1000)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_range)<br>`let i: i32 = rng.gen()`|[`nextInt(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#nextInt(int,int))|
|[`rng.gen_range(10_000u64..20_000u64)`](https://docs.rs/rand/latest/rand/trait.Rng.html#method.gen_range)<br>`let l: u64 = rng.gen()`|[`nextLong(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#nextLong(long,long))|
|[`TODO`](TODO)|[`nextDouble()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#nextDouble(double,double))|
|[`TODO`](TODO)|[`ints()`](TODO)|
|[`TODO`](TODO)|[`longs()`](TODO)|
|[`TODO`](TODO)|[`doubles()`](TODO)|
|[`let mut rng = rand::thread_rng()`](https://docs.rs/rand/latest/rand/fn.thread_rng.html)|[`var rng = ThreadLocalRandom.current()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ThreadLocalRandom.html#current())|
|[`cksac/fake-rs`](https://crates.io/crates/fake)|[`DiUS/Faker`](https://github.com/DiUS/java-faker)|
|[``](TODO)|[``](TODO)|

- TODO: gen_range