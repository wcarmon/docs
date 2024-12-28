# Overview

1. What are [Signals](TODO)


# Why (Value proposition)

1. Less computation during change detection
1. Progress toward [zone.js](TODO) removal


# What are Signals
1. Wrapper around a value, which notifies
1. Observable pattern
1. Like a [BehaviorSubject](TODO) (cold)
1. Can be read-only or [read-write](https://angular.dev/guide/signals#writable-signals)
    - [`Signal`](TODO)
    - [`WritableSignal`](TODO)
        - expose read-only view using [`.asReadonly()`](TODO)
1. Simpler subset of rxjs (think `.map`, `.filter`, etc)
   1. but Angular specific (unlike rxjs)
1. Fine grained changes (unlike Zone.js)  <-- TODO: explain this
1. Signals keep track of their dependencies


# Write
```ts
const v: WritableSignal<string> = signal("foo");

v.set("bar");  // set & notify directly
v.update(old => old + ",new");  // transform previous value
```


# Read
```ts
const v: WritableSignal<number> = signal(57);

assert(v() == 57);
```


# Composition ([Computed signals](https://angular.dev/guide/signals#computed-signals))
1. use [`computed(...)`](TODO)
1. derived signals auto-update
1. derived signals are cached until dependencies change
```ts
const v: WritableSignal<number> = signal(1);

const plus3: Signal<number> = computed(() => v() + 3);
```


# Value Equality
1. You can replace the equality fn
1. Default equality test: [`Object.is`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is) 
```ts
import _ from "lodash";
const sig = signal(['test'], {equal: _.isEqual});
```


# Side effects
1. prefer `computed(...)` over `effect(...)`, where possible
1. Idiom: only build an effect in component ctor
1. [`effect`](https://angular.dev/guide/signals#effects) runs when a signal value changes
1. [`effect`](https://angular.dev/guide/signals#effects) run at least once
1. like a manual `.subscribe(...)` in Rx
1. Useful for 
    - keeping data in sync (eg. to window.localStorage)
    - custom dom behavior
    - logging
    - debugging
    


# Angular Components
1. TODO: enabling on components
    1. `changeDetection: ChangeDetectionStrategy.OnPush,`
1. Templates
```html
...
<div>
    value is {{mySignal()}}
</div>
...
```


- TODO: `batch`: group emissions, TODO: rx equivalent
- TODO: `untracked`: avoids infinite loop, for network IO


# Other Resources
