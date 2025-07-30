# Overview
1. Managing state within and across components
1. TL;DR: use [zustand](https://github.com/pmndrs/zustand)


# Option 1: Zustand
1. TODO


# Option 2: Component variables
1. private, not shared
1. Lost between refreshes
1. Useful only for temporary state


# Option 3: [useState](https://react.dev/reference/react/useState)
1. private, not shared
1. Outlives the component
1. `Con`: Not robust
1. `Con`: Hard to reason about correctness (looks in nearest provider)
1. `Con`: not a scalable solution
1. `Con`: must be careful about when and where you invoke `useState`
1. `Con`: must be careful about setting value directly (prefer an updater lambda/closure)
1. `Con`: must be aware of the render cycle (to avoid reading old value)
1. `Con`: [many other gotchas](https://react.dev/reference/react/useState#setstate-caveats)



# ~~Option 4~~: Component properties


# ~~Option 5~~: [useContext](https://react.dev/reference/react/useContext) hook
1. `Con`: Not robust
1. `Con`: Hard to reason about correctness (looks in nearest provider)
1. `Con`: requires you to wrap some top-level dom element
1. `Con`: [many gotchas about proper usage](https://react.dev/reference/react/useContext#caveats)
1. `Con`: messy if your dom has mult
1. `Con`: always uses `===` for comparison


# ~~Option 6~~: [Redux](https://redux.js.org/)
1. `Pro`: Nice ideas
1. `Pro`: Nice tools
1. `Pro`: Scales better than `useContext` or `useState`
1. `Con`: WAAAAY too much Boilerplate


# TODO:
- https://react.dev/reference/react/useReducer


# Other Resources
1. TODO
