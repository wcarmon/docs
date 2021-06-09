# Overview
- Why we should sort?
- How to do it automatically?

--------
# Table of Contents
- [Why?](#why)
    * [Item-01: Simplifies finding duplicates](#item-01-simplifies-finding-duplicates)
    * [Item-02: Simplifies finding missing items](#item-02-simplifies-finding-missing-items)
    * [Item-03: Simplifies finding elements](#item-03-simplifies-finding-elements)
    * [Item-04: Simplifies code merges](#item-04-simplifies-code-merges)
    * [Item-05: Simplifies Code reviews](#item-05-simplifies-code-reviews)
- [How? - Automation!](#how---automation)
    * [Intellij IDEA](#intellij-idea)
    * [VSCode](#vscode)
    * [Vim](#vim)
    * [Emacs](#emacs)
    * [Sublime](#sublime)
    

--------
# Why?

## Item-01: Simplifies finding duplicates
- When sorted, duplicates appear together

### Example:
- Where's the duplicate (unsorted): `5, 3, 1, 4, 3, 2`
- Where's the duplicate (sorted): `1, 2, 3, 3, 4, 5`
- *Answer for both: `3`*


## Item-02: Simplifies finding missing items
- When sorted, every item has a place, so it's obvious when it's missing

### Example:
- What's missing? (unsorted): `5, 1, 3, 2`
- What's missing? (sorted): `1, 2, 3, 5`
- *Answer for both: `4`*


## Item-03: Simplifies finding elements
- Think binary search
- Imagine a long list of States on an order form for an e-commerce site
- Less Engineer time wasted finding things


## Item-04: Simplifies code merges
- Easier to determine common & distinct changes (intersection, union, difference)
- Less merge bugs, lower maintenance costs

### Example:
- What numbers are common? (unsorted): `2, 1, 3` and `4, 2, 3`
- What numbers are common? (sorted): `1, 2, 3` and `2, 3, 4`
- *Answer for both: `2, 3`*


## Item-05: Simplifies Code reviews
- For all the reasons above
- Engineers more likely to review cleaner code
- Engineers more likely to catch duplicate & missing item bugs


--------
# How? - Automation!
## Intellij IDEA
- [Line sorter plugin](https://plugins.jetbrains.com/plugin/5919-lines-sorter)
- [JSON sorter plugin](https://plugins.jetbrains.com/plugin/11104-json-sorter)


## VSCode
- [Sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines)


## Vim
- [`:sort`](https://vim.fandom.com/wiki/Sort_lines)


## Emacs 
- [Sorting](https://www.gnu.org/software/emacs/manual/html_node/emacs/Sorting.html)


## Sublime
- [Sorting](https://packagecontrol.io/packages/SortBy)
