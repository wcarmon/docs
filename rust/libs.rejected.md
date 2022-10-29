# Case conversion
## ~~SkylerLipthay/case~~
1. no tests
1. abandonware
1. < 20 stars

# Async IO


# Concurrency (CPU, Data parallelism)


# DI
1. ~~coi~~
    1. lots of syntax

1. ~~depcon~~
    1. Runtime based (`Arc`)

1. ~~hairspray~~
    1. overly complex
    1. they use macros for things defined by the language already like `#[implements(Foo)]`
    1. it cannot decide if it's macro based on function based
    1. see `Construct` trait

1. ~~indep~~
    1. Immature API
    1. Abandonware
    1. Poor documentation
    1. Unpopular (<4 stars)

1. ~~Shaku~~
    1. requires types to have `#[derive(Component)]`
        1. for external types, you'd have to wrap & redeclare
    1. must re-declare implemented traits in attribute (`#[shaku(interface = FooTrait)]`)

1. ~~syrette~~
    1. requires your API to depend on syrette::ptr (eg. `TransientPtr`)
    1. have to invoke `bind` even though you used `#[injectable(Foo)]` attribute


# DateTime


# Protocol buffers


# Random


# Retry


# Serde / JSON


# String / Case conversion


# Test / Assertions
1. ~~stainless-steel~~
    1. abandonware

1. ~~cfrancia/spectral~~
    1. abandonware


# Test / Fake data
