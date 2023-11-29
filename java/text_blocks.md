# Overview
1. Key points about Java 14+ [Text blocks](TODO)

# Idioms
1. The **least** indented line controls indentation
1. Use [`.indent(n)`](TODO) to manually force indentation
1. Trailing space on each line is auto-trimmed by the compiler
    1. there are idioms to retain some trailing spaces like [character fence](TODO) and `\s` chars
1. [`-Xlint:text-blocks`](TODO) compiler flag can catch common misuse
1. **Don't** align with the opening/starting `"""`
    1. there's no point
    1. opening `"""` doesn't affect indentation
    1. it makes refactoring unsafe (eg. variable length change affects indentation)
1. Avoid ~~[`.stripIndent()`](TODO)~~ since it just does what they compiler already does
    1. rare edge case: reading text block from Standard.in or a file
1. Put the end `"""` in one of two places
    1. After the final character of text
        1. Text block will end with the final character of the text
    1. On the line after the final char of the text, aligned with the last line
        1. Text block will end with a `\n`


# Other resources
1. TODO
