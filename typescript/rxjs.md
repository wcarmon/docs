# Overview
1. TODO



# Filtering: [distinctUntilChanged](https://rxjs.dev/api/index/function/distinctUntilChanged)
1. Uses `===` by default
1. Custom comparison fn should return true when values equivalent
```ts
.pipe(
  distinctUntilChanged((pref,curr) => prev.foo == curr.foo),
  // ...
)
```


# Filtering: [debounceTime](https://rxjs.dev/api/operators/debounceTime)
1. Emit only when it's been "long enough" since the last emission
1. Tends to slow down the UI (while waiting to settle down)
1. Prefer `sampleTime` unless you know the advantages of debounce


# Filtering: [sampleTime](https://rxjs.dev/api/operators/sampleTime)
1. Emit once per time window
1. Only emit if source emitted in time window
1. https://reactivex.io/documentation/operators/sample.html


# Filtering: [throttleTime](https://rxjs.dev/api/operators/throttleTime)
1. Emit once per time window with latest value
1. Emit even if source does NOT emit in the time window
1. Prefer `sampleTime` unless you know the advantages of debounce


# Other resources
1. https://thinkrx.io/rxjs/debounceTime-vs-throttleTime-vs-auditTime-vs-sampleTime/
