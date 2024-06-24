# Overview
1. TODO



# [debounceTime](https://rxjs.dev/api/operators/debounceTime)
1. Emit only when it's been "long enough" since the last emission
1. Tends to slow down the UI (while waiting to settle down)
1. Prefer `sampleTime` unless you know the advantages of debounce


# [sampleTime](https://rxjs.dev/api/operators/sampleTime)
1. Emit once per time window
1. Only emit if source emitted in time window
1. https://reactivex.io/documentation/operators/sample.html


# [throttleTime](TODO)
1. Emit once per time window with latest value
1. Emit even if source does NOT emit in the time window
1. Prefer `sampleTime` unless you know the advantages of debounce


# Other resources
1. https://thinkrx.io/rxjs/debounceTime-vs-throttleTime-vs-auditTime-vs-sampleTime/
