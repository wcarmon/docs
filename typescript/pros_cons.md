# Overview
1. Things that are excellent about Typescript
1. Things that are terrible about Typescript


# Good news
1. Supported by every browser
1. Large ecosystem
1. Many ways to solve almost every problem
1. [Constantly Improving](https://en.wikipedia.org/wiki/ECMAScript#History)
1. Template strings (compare to java)
1. Any site is a REPL
1. Developer tools in Chrome/Firefox


# Bad news
1. Karma debugging is hard (with breakpoints)
1. Promises are hard because you cannot reject from outside the builder
1. Slow compilation (transpilation)
1. [Comparing objects is harder than it should be](https://stackoverflow.com/questions/1068834/object-comparison-in-javascript)
    1. `JSON.stringify` comparison is order sensitive
    1. most reliable option is lodash
    1. compare to go, rust, python, java (Object::equals), etc
1. null & undefined
1. truthiness
1. importing types is harder than it should be
    1. [example](https://upmostly.com/angular/using-lodash-with-angular)
1. [target browser differences](https://caniuse.com/)
1. types can get out of sync with sources (eg. @types repo vs source repo)
1. Single threaded
    1. Web workers aim to help
1. Karma debugging is hard
    1. Process lingers
    1. `debugger` doesn't work
    1. fortunately `console.log` does work


# Other Resources
1. TODO
