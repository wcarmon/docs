# Overview
1. Summary of Jenkins pipeline file syntax


# Concepts
1. `pipeline`: user-defined model of CI/CD, describes entire build process
1. `node`: a jenkins machine, which executes pipeline
1. `stage`: distinct subset of tasks, shows visually on status page, timed
1. `step`: atomic task
1. `agent`: allocate executor and workspace on a `node`
1. `post`: conditional actions run after `stage` or `pipeline` completes
1. `sh`: execute shell script
1. `matrix`: ?
1. `stages`: sequential (not parallel)


# Valid syntax
## Pipeline
- `pipeline.agent`
- `pipeline.environment`
- [`pipeline.options`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.buildDiscarder`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.checkoutToSubdirectory`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.disableResume`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.parallelsAlwaysFailFast()`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.quietPeriod`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.retry`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.skipDefaultCheckout`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.timeout`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- [`pipeline.options.timestamps`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)
- `pipeline.parameters`
- `pipeline.parameters.booleanParam`
- `pipeline.parameters.choice`
- `pipeline.parameters.password`
- `pipeline.parameters.string`
- `pipeline.parameters.text`
- [`pipeline.post`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.aborted`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.always`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.changed`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.cleanup`](https://www.jenkins.io/doc/book/pipeline/syntax/#post) // like finally
- [`pipeline.post.failure`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.fixed`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.success`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.unstable`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.stages`](https://www.jenkins.io/doc/book/pipeline/syntax/#stages)
- [`pipeline.stages.stage[i]`](https://www.jenkins.io/doc/book/pipeline/syntax/#stages)
- `pipeline.stages.stage[i].steps`
- `pipeline.triggers`


## Node
- `node.stage[i]`
- `node.stage[i]`.`if ...`
- `node.stage[i]`.`try... catch ... finally ...`


# Stage
- `stage.agent`
- `stage.agent.label`
- `stage.environment` // key value pairs
- `stage.failFast`
- `stage.options.retry`
- `stage.options.timeout`
- `stage.options.timestamps`
- `stage.parallel`
- `stage.parallel.stage[i]`
- [`stage.parallel.stage[i].steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- [`stage.post`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.aborted`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.always`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.changed`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.cleanup`](https://www.jenkins.io/doc/book/pipeline/syntax/#post) // like finally
- [`stage.post.failure`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.fixed`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.success`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`stage.post.unstable`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- `stage.stages.stage.parallel.stage[i]`
- [`stage.stages.stage.parallel.stage[i].steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- [`stage.stages.stage.steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- [`stage.steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- `stage.steps.echo`
- `stage.steps.junit`
- `stage.steps.script` // groovy script
- `stage.steps.sh`
- `stage.tools`
- `stage.when`
- `stage.when.branch`
- `stage.`{`steps` | `stages` | `parallel` | `matrix`}


# Matrix
- `matrix.agent.label`
- `matrix.axes.axis[i].name`
- `matrix.axes.axis[i].values`
- `matrix.excludes`
- `matrix.excludes.exclude[i].axis[i].name`
- `matrix.excludes.exclude[i].axis[i].values`
- `matrix.stages`
- `matrix.stages.stage[i]`
- `matrix.stages.stage[i].steps`
- `matrix.when`
- `matrix.when.anyOf`
- `matrix.when.anyOf.expression[i]`


# Other
1. The `Jenkinsfile` auto updates the stored job config


# Other resources
1. https://www.jenkins.io/doc/book/pipeline/syntax/
