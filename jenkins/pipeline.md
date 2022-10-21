# Overview
1. Summary of Jenkins pipeline file syntax
1. (unfortunately) uses Groovy DSL


# Concepts
1. [`pipeline`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-pipeline): user-defined model of CI/CD, describes entire build process (DSL based)
1. [`node`](https://www.jenkins.io/doc/book/pipeline/syntax/#flow-control): a jenkins machine, which executes pipeline (scripting/code based)
1. `stage`: distinct subset of tasks, shows visually on status page, timed
1. `step`: atomic task
1. `agent`: allocate executor and workspace on a `node`
1. `post`: conditional actions run after `stage` or `pipeline` completes
1. `sh`: execute shell script
1. `matrix`: ?
1. `stages`: sequential (not parallel)


# Valid syntax

## Pipeline (Top level)
- `pipeline.agent`
- `pipeline.agent.node`
- [`pipeline.environment`](https://www.jenkins.io/doc/book/pipeline/syntax/#environment)
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
- [`pipeline.parameters`](https://www.jenkins.io/doc/book/pipeline/syntax/#parameters)
- [`pipeline.parameters.booleanParam`](https://www.jenkins.io/doc/book/pipeline/syntax/#available-parameters)
- [`pipeline.parameters.choice`](https://www.jenkins.io/doc/book/pipeline/syntax/#available-parameters)
- [`pipeline.parameters.password`](https://www.jenkins.io/doc/book/pipeline/syntax/#available-parameters)
- [`pipeline.parameters.string`](https://www.jenkins.io/doc/book/pipeline/syntax/#available-parameters)
- [`pipeline.parameters.text`](https://www.jenkins.io/doc/book/pipeline/syntax/#available-parameters)
- [`pipeline.post`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.aborted`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.always`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.changed`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.cleanup`](https://www.jenkins.io/doc/book/pipeline/syntax/#post) // like finally
- [`pipeline.post.failure`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.fixed`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.post.success`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- `pipeline.post.success.archiveArtifacts`
- [`pipeline.post.unstable`](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
- [`pipeline.stages`](https://www.jenkins.io/doc/book/pipeline/syntax/#stages)
- [`pipeline.stages.stage[i]`](https://www.jenkins.io/doc/book/pipeline/syntax/#stages)
- `pipeline.stages.stage[i].steps`
- [`pipeline.triggers`](https://www.jenkins.io/doc/book/pipeline/syntax/#triggers)
- [`pipeline.tools`](https://www.jenkins.io/doc/book/pipeline/syntax/#tools)


## Node (Top level)
- `node.stage[i]`
- `node.stage[i]`.`if ...`
- `node.stage[i]`.`try... catch ... finally ...`


## Stage
- `stage.agent`
- `stage.agent.docker`
- `stage.agent.label`
- [`stage.environment`](https://www.jenkins.io/doc/book/pipeline/syntax/#environment) // key value pairs
- `stage.failFast`
- `stage.options.retry`
- `stage.options.timeout`
- `stage.options.timestamps`
- [`stage.parallel`](https://www.jenkins.io/doc/book/pipeline/syntax/#parallel)
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
- [`stage.stages.stage[i].parallel`](https://www.jenkins.io/doc/book/pipeline/syntax/#parallel)
- `stage.stages.stage[i].parallel.stage[i]`
- [`stage.stages.stage[i].parallel.stage[i].steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- [`stage.stages.stage[i].steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- [`stage.steps`](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-steps)
- `stage.steps.echo`
- `stage.steps.junit`
- `stage.steps.script` // groovy script
- `stage.steps.sh`
- [`stage.tools`](https://www.jenkins.io/doc/book/pipeline/syntax/#tools)
- [`stage.when`](https://www.jenkins.io/doc/book/pipeline/syntax/#when)
- [`stage.when.allOf`](https://www.jenkins.io/doc/book/pipeline/syntax/#built-in-conditions)
- [`stage.when.anyOf`](https://www.jenkins.io/doc/book/pipeline/syntax/#built-in-conditions)
- [`stage.when.branch`](https://www.jenkins.io/doc/book/pipeline/syntax/#built-in-conditions)
- [`stage.when.environment`](https://www.jenkins.io/doc/book/pipeline/syntax/#built-in-conditions)
- [`stage.when.equals`](https://www.jenkins.io/doc/book/pipeline/syntax/#built-in-conditions)
- [`stage.when.expression`](https://www.jenkins.io/doc/book/pipeline/syntax/#built-in-conditions)
- `stage.`{exactly one of: `steps` | `stages` | `parallel` | `matrix`}


## Matrix
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
1. https://github.com/cherkavi/cheat-sheet/blob/master/jenkins.md
1. https://github.com/jenkinsci/pipeline-examples/blob/master/declarative-examples/jenkinsfile-examples/mavenDocker.groovy
1. https://github.com/jenkinsci/pipeline-examples/blob/master/docs/BEST_PRACTICES.md
1. https://github.com/jenkinsci/pipeline-examples/blob/master/jenkinsfile-examples/android-build-flavor-from-branch/JenkinsFile
1. https://github.com/jenkinsci/pipeline-examples/blob/master/jenkinsfile-examples/msbuild/Jenkinsfile
1. https://github.com/jenkinsci/pipeline-examples/blob/master/pipeline-examples/archive-build-output-artifacts/ArchiveBuildOutputArtifacts.groovy