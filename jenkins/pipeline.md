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
- `pipeline.options`
- `pipeline.options.buildDiscarder`
- `pipeline.options.checkoutToSubdirectory`
- `pipeline.options.disableResume`
- `pipeline.options.parallelsAlwaysFailFast()`
- `pipeline.options.quietPeriod`
- `pipeline.options.retry`
- `pipeline.options.skipDefaultCheckout`
- `pipeline.options.timeout`
- `pipeline.options.timestamps`
- `pipeline.parameters`
- `pipeline.parameters.booleanParam`
- `pipeline.parameters.choice`
- `pipeline.parameters.password`
- `pipeline.parameters.string`
- `pipeline.parameters.text`
- `pipeline.post`
- `pipeline.post.aborted`
- `pipeline.post.always`
- `pipeline.post.changed`
- `pipeline.post.cleanup` // like finally
- `pipeline.post.failure`
- `pipeline.post.fixed`
- `pipeline.post.success`
- `pipeline.post.unstable`
- `pipeline.stages`
- `pipeline.stages.stage[i]`
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
- `stage.parallel.stage[i].steps`
- `stage.post`
- `stage.post.aborted`
- `stage.post.always`
- `stage.post.changed`
- `stage.post.cleanup` // like finally
- `stage.post.failure`
- `stage.post.fixed`
- `stage.post.success`
- `stage.post.unstable`
- `stage.stages.stage.parallel.stage[i]`
- `stage.stages.stage.parallel.stage[i].steps`
- `stage.stages.stage.steps`
- `stage.steps`
- `stage.steps.echo`
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


# Other resources
1. https://www.jenkins.io/doc/book/pipeline/syntax/
