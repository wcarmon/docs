# Overview
1. How to setup [Angular](https://angular.io/) and [Angular CLI](https://angular.io/cli)


# NodeJS
- See [setup doc](../setup.node.md)


# NG
```bash
npm install -g @angular/cli
```


# New Angular app
```bash
cd /path/to/web/projects

# replace the line below
APP_NAME=some-app

ng new $APP_NAME
# follow the prompts:   eg. enable routing, use less, ...
```

## Verify
```bash
cd $APP_NAME
ng serve --open
```


# [angular.json](https://angular.io/guide/workspace-config) (Angular workspace config)
1. The format/structure changes between versions
1. Add your global styles 
```js
    // Add to:  projects.<projectName>.architect.build.options.styles
    // Add to:  projects.<projectName>.architect.test.options.styles
    
    "styles": [
        "node_modules/normalize.css/normalize.css",
        "node_modules/toastify-js/src/toastify.css",
    ],
    ...
```
1. Change the [`prefix`](https://angular.io/guide/workspace-config#project-configuration-options) to match your app
1. Set `baseHref`, eg. `/static/`
    - `projects.<projectName>.architect.build.options.baseHref`


# tsconfig
- See https://angular.io/config/tsconfig
- See https://www.typescriptlang.org/docs/handbook/tsconfig-json.html
- All are used only at CI/Build-time (not runtime) 

## Files 
1. `tsconfig.json`: Global
1. `tsconfig.app.json`: App specific overrides on `tsconfig.json` (eg. when you have multiple apps)
1. `tsconfig.spec.json`: For Tests
1. `tsconfig.eslint.json`: For static analysis
1. `tsconfig.worker.json`: For Service workers


# Other resources
1. https://angular.io/cli
1. https://angular.io/guide/setup-local
