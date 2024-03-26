# Overview
1. A faster, more strict replacement for [npm](https://www.npmjs.com/)


# Pros
1. faster (written in rust)
1. global cache instead of local (same as gradle or maven)
1. allows multiple versions installed
1. compatibility with npm & yarn
    1. near perfect alignment on the CLI API

# Cons
1. Doesn't support phantom dependencies
1. More strict about peer dependencies
1. Some packages might not work because pnpm is mroe strict


# Setup
1. `npm install -g pnpm`


# Other Resources
1. https://medium.com/@buffet_time/why-you-should-move-to-pnpm-82962f332418
