# Overview
1. Demonstrates modules
1. Shows how to create & reference child/parent modules


# Module Structure
- crate-root (`lib.rs`) / `top` / `left` / `bottom`
- crate-root (`lib.rs`) / `top` / `right` / `bottom`
- crate-root (`main.rs`) / `top` / `left` / `bottom`
- crate-root (`main.rs`) / `top` / `right` / `bottom`
- `left` & `right` are at the same level to demonstrate "lateral/sibling" references
