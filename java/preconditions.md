# Overview
- What are [Preconditions](https://github.com/google/guava/wiki/PreconditionsExplained)?
- Why should we use them?


# Table of contents
- [Benefits](#benefits)
- [Intellij - Live templates](#intellij---live-templates)
- [More Info](#more-info)


--------
# Definition
1. Precondition == a Validation/check done before using a variable
    1. eg. Before parsing a phone number, make sure it's not blank or `null`
1. Real world examples:
    1. eg. *"Before I look at this form, did you complete all the required items"*
    1. eg. *"Before I issue this loan to you, let's check your credit"*


# Benefits
1. Errors don't drift away from the root cause (reduces [MTTR](https://www.atlassian.com/incident-management/kpis/common-metrics))
1. Assumptions are documented and enforced (reduces maintenance costs)
1. Many errors are caught at startup (for constructor preconditions)


# Intellij - Live templates
1. Intellij [Live templates](https://www.jetbrains.com/help/idea/using-live-templates.html) save you time
1. They build code constructs based on [a few keystrokes](https://www.jetbrains.com/help/idea/creating-and-editing-live-templates.html)
1. Below are some templates I found useful ([also linked here, so you can import](./intellij/wc-live-templates.xml))
1. You can [share your templates too](https://www.jetbrains.com/help/idea/sharing-live-templates.html)

## Precondition for non-blank strings
1. Abbreviation: `cbs` ("**c**heck **b**lank **s**tring"), replace with something memorable for you
1. Template Text:
```java
com.google.common.base.Preconditions.checkArgument(org.apache.commons.lang3.StringUtils.isNotBlank($VAR$), "$VAR$ is required" );
```
1. Applicable in: `Java expression`, `Java Statement`
1. Options: `Shorten FQ names`

## Precondition for non-null obj reference
1. Abbreviation: `rnn` ("**r**equire **n**ot **n**null"), replace with something memorable for you
1. Template Text:
```java
java.util.Objects.requireNonNull($VAR$, "$VAR$ is required and missing.");
```
1. Applicable in: `Java expression`, `Java Statement`
1. Options: `Shorten FQ names`


# More Info
1. [Guava docs](https://github.com/google/guava/wiki/PreconditionsExplained)
1. [nice article about them](https://michaelbfullan.com/the-joys-of-guava-preconditions/)
1. [baeldung](https://www.baeldung.com/guava-preconditions)
