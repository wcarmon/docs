# Overview
1. Tips for keeping quality high and reducing frustration


# Multiple passes over the code
1. Think thru the problem
1. Draw major components out (eg. on paper or digital)
1. Setup [Guard rails](../common/guard_rails.md)
1. Tackle one small piece
    1. Build some of the model (structs, entities)
    1. Build some utility/associated functions
    1. Add some methods
    1. Connect functions using [todo!()](https://doc.rust-lang.org/std/macro.todo.html) implementations
    1. Simplify
    1. Split independent parts into [separate crates](./abstraction.md)
    1. Make it compile
    1. [Add unit tests](./testing.unit.md)
    1. Make it run
    1. [Make error handling more robust](./errors.md) (error `enum`, clear messages)
    1. Fix issues listed by [clippy](./static_analysis.md)
    1. Find & use [high-quality libraries](/home/wcarmon/git-repos/docs/general/libraries.md) which do things better than you are
    1. Remove most [`.clone()`](https://doc.rust-lang.org/std/clone/trait.Clone.html)
    1. Minimize [visibility/exposure](/home/wcarmon/git-repos/docs/rust/modules.md) (eg. `pub`, `pub(crate)`)
    1. Extract [Traits](./traits.md), Reuse built-in traits   
    1. Check for Thread-safety, simplify (eg. message passing, Rayon, Crossbeam, Tokio)
    1. Cleanup rustdocs
    1. Remove unnecessary [derive](./traits.derive.md) traits 
    1. Benchmark/Profile
        1. Look for caching opportunities
    1. Integrate with the rest of the code
1. Repeat
