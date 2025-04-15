# Overview
1. TODO


# Cons
1. Relatively immature (compared to json or protobuf)
1. Incompatible with other languages (compare to protobuf or json or bson ...)
1. Serious incompatibilities with serde crate
    1. Mitigate: don't use with serde interface
1. Annoying issues with enums
    - `#[bincode(context = ())]` is ignored by derive macros on non-trivial enums
    - manually implementing `Decode` for enums is hard
1. `__Context` is a nightmare, and forces you to manually impl `Decode` for most types
1. Incompatible with newtype pattern
1. Don't don't have any examples of macro usage or customizations
    1. Tests have some examples
1. feels like a battle (huge waste of type for any non-trivial model)


# Other resources
1. TODO
