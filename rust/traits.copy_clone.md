# Overview
1. Differentiating between [`Clone`](TODO) and [`Copy`](TODO) traits in Rust.


||[`Clone`](TODO)|[`Copy`](TODO)|
|---|---|---|
|TODO|Explicit duplication|Implicit|
|Runtime cost|cheap or expensive|must be cheap|
|Depth|Deep or shallow|deep|
|Extra behavior?|Add arbitrary extra behavior|no|
|Move semantics|no change|Replaces move with copy semantics|


# [Copy](TODO)
1. Implicit duplication (Automatic replication)
    1. eg. assignments, fn invocations, etc
1. Bitwise copy
    1. No extra behavior beyond bitwise copy
1. Must be computationally cheap



# Other resources
1. TODO
