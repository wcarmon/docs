# Overview
1. Key points about Java 14+ [Text blocks](https://docs.oracle.com/en/java/javase/15/text-blocks/index.html)


# Idioms
1. The **least** indented line controls indentation
1. Use [`.indent(n)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html#indent(int)) to manually force indentation
1. Trailing space on each line is auto-trimmed by the compiler
    1. there are idioms to retain some trailing spaces like [character fence](https://docs.oracle.com/en/java/javase/21/text-blocks/index.html#trailing-white-space) and `\s` chars
1. [`-Xlint:text-blocks`](https://docs.oracle.com/en/java/javase/17/docs/specs/man/javac.html#examples-of-using--xlint-keys) compiler flag can catch common misuse
1. **Don't** align with the opening/starting `"""`
    1. there's no point
    1. opening `"""` does **NOT** affect indentation
    1. it makes refactoring unsafe (eg. variable length change affects indentation)
1. Avoid ~~[`.stripIndent()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html#stripIndent())~~ since it just does what they compiler already does
    1. [rare edge case: reading text block from Standard.in or a file](https://docs.oracle.com/en/java/javase/21/text-blocks/index.html#string-stripindent)
1. Put the closing `"""` in one of two places
    1. [After the final character of text](https://docs.oracle.com/en/java/javase/21/text-blocks/index.html#that-final-new-line)
        1. Text block will end with the final character of the text
    1. [On the line after the final char of the text, aligned with the last line](https://docs.oracle.com/en/java/javase/21/text-blocks/index.html#that-final-new-line)
        1. Text block will end with a `\n`


# Other Resources
1. https://openjdk.org/jeps/378
1. https://docs.oracle.com/en/java/javase/15/text-blocks/index.html
