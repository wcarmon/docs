# Overview
1. Approach to libraries


# Table of Contents
- [Don't reinvent the wheel](#don-t-reinvent-the-wheel-)
- [Library vs Framework](#library-vs-framework)
  * [Library](#library)
  * [Framework](#framework)
- [Selecting a good library](#selecting-a-good-library)
- [More resources](#more-resources)


# Don't reinvent the wheel!
1. There are hundreds of high-quality libraries for every [popular language](https://www.tiobe.com/tiobe-index/)
1. Fight the urge to write from scratch
1. Avoid [NIH](https://en.wikipedia.org/wiki/Not_invented_here) syndrome
1. [Utilities](../java/classes.utility.md)
1. Awesome lists
    1. [akullpp (Java)](https://github.com/akullpp/awesome-java)
    1. [all awesomerepos](https://awesomerepos.io/)


# Library vs Framework
## Library
1. Your code calls a library (utility)
1. Saves you time (Written & maintained by someone else)
1. Limited scope, focused, [modular](https://en.wikipedia.org/wiki/Modular_programming), minimal, [composable](https://en.wikipedia.org/wiki/Composability), flexible
1. Easily swapped out when your needs change
1. Simpler than framework
1. Implies clean [seams](https://biratkirat.medium.com/working-effectively-with-legacy-code-changing-software-part-1-chapter-4-b997b78fc0a2) (simplifies code evolution)


## Framework
1. Frameworks call your code as part of some larger lifecycle
1. Saves you time *today* (Written & maintained by others)
1. Frameworks [take-over](https://martinfowler.com/bliki/InversionOfControl.html) (you relinquish control)
1. Generally better for throw-away code (think [hackathons](https://en.wikipedia.org/wiki/Hackathon))
1. Vendor lock-in
1. More complex than a library (often uses many libraries)
1. Steeper learning curve than a library (the instant it doesn't meet your needs)
1. Tends toward bloat over time
    1. They cannot remove features since people are still using them
1. Upgrades are all-or-nothing
    1. Cannot upgrade part of a framework
    1. Locked into strict version cycle
1. Frameworks can be great until you need something the authors didn't think of
1. Some projects have both Framework and Library features (eg. [Spring](https://github.com/spring-projects/spring-framework))


# Selecting a good library
1. Choose a Library over a Framework (99.9% of the time)
1. License
    1. License must meet **your** legal requirements
    1. Common [Permissive](https://en.wikipedia.org/wiki/Permissive_software_license) licenses include: [MIT License](https://choosealicense.com/licenses/mit/), [Apache License](https://choosealicense.com/licenses/apache-2.0/), ...
1. [Open Source](https://opensource.org/osd)
    1. Sources available on [Github](https://github.com/)
    1. Simplifies [debugging](https://en.wikipedia.org/wiki/Debugging) (when it's behaving unexpectedly)
    1. Simplifies [profiling](https://en.wikipedia.org/wiki/Profiling_(computer_programming)) (when it's too slow)
    1. Simplifies contributing (when you find bugs)
1. Actively developed
    1. No [abandonware](https://en.wikipedia.org/wiki/Abandonware)
    1. Has [commit](https://www.atlassian.com/git/tutorials/saving-changes/git-commit)s from the last 3-months (Unless it is "Feature complete")
1. Well Documented
    1. Clear [javadoc](https://en.wikipedia.org/wiki/Javadoc)/[kdoc](https://kotlinlang.org/docs/kotlin-doc.html)/[jsdoc](https://jsdoc.app/)/[tsdoc](https://tsdoc.org/) in sources
    1. Clear wiki or [readme.md](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) explaining how to use
1. Well Tested
    1. Tests must exercise all the functionality important to your use case
    1. Tests must exercise edge cases
    1. 50%+ coverage
        1. 100% is a excessive, no one should test boilerplate, getters, setters, ...
1. Compatible with your future
    1. Library must be compatible with your future **tools** & **platform**
1. Clean source code
    1. "Well structured"
    1. Code is organized into packages/directories
    1. Code is well formatted (Perhaps even auto-formatted)
    1. Follows popular coding standards
    1. Passes static analysis tools (like [PMD](https://pmd.github.io/), [eslint](https://eslint.org/), ...)
    1. Code uses data structures correctly
    1. Code uses types correctly
1. Code must align with the platform
    1. Code must follow common idioms for the platform (eg. jvm, cpython, node)
    1. Includes things like distribution mechanism (maven, gradle, jar, npm, setuptools, ...)
1. Thread-safe
    1. Code must be safe to use across Threads
    1. Unsafe libraries don't scale & create subtle bugs
    1. Mature libraries document Thread Safety
    1. Prefer [stateless](https://www.redhat.com/en/topics/cloud-native-apps/stateful-vs-stateless) libraries (which are inherently thread-safe)
1. Observable
    1. Libraries should be compatible with your [logging, tracing & metrics](https://www.oreilly.com/library/view/distributed-systems-observability/9781492033431/ch04.html) tools
1. Popular
    1. Check the star count on github
    1. Search for articles written about the library
    1. See [Linus's law](https://en.wikipedia.org/wiki/Linus%27s_law)
1. Performant
    1. [Benchmarks](https://en.wikipedia.org/wiki/Benchmark_(computing)) included
    1. Fast enough for your use case


# More resources
1. [stackoverflow.com :: framework-v-library](https://stackoverflow.com/questions/148747/what-is-the-difference-between-a-framework-and-a-library)
