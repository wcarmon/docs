# Overview
1. Tips for keeping quality high and reducing frustration


# Custom Global css
1. eg. things like [normalize.css]
1. Add to [`angular.json`](https://angular.io/guide/workspace-config#angular-workspace-configuration)
  - [`/projects/<project-name>/architect/build/options/styles`](https://angular.io/guide/workspace-config#style-script-config)


# [Routing strategy](https://angular.io/guide/router#choosing-a-routing-strategy)
1. Use HTML5 style ([PathLocationStrategy](https://angular.io/api/common/PathLocationStrategy))
1. Server must route all requests to `index.html`
    1. angular cli does this for you locally automatically 
1. [Set Base href](https://angular.io/guide/router#base-href)

## Baseurl
1. Add to [`angular.json`](https://angular.io/guide/workspace-config#angular-workspace-configuration)
    - [`/projects/<project-name>/architect/build/options/baseHref`](https://angular.io/guide/workspace-config#base-href)
1. Add to `index.html`
    - TODO: see https://angular.io/guide/deployment#the-base-tag


# [Karma](https://angular.io/guide/testing#configuration)
1. See https://angular.io/guide/testing#configuration
1. create/update `karma.conf.js`
1. update `angular.json`
    - `/projects/<project-name>/architect/test/options`


# WebStorm Debugger
- TODO


# WebStorm Test Debugger
- TODO


# Gotchas
1. Angular material doesn't work with html tables, must use CSS Flex
    1. eg. MatSelect

# Other resources
1. TODO
