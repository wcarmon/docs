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
    - Add any extra ES features to [`compilerOptions.lib`](https://www.typescriptlang.org/tsconfig#individual-library-components) 
        - "ES2015.Collection",
        - "ES2021.String",
        - "ES2018.Promise",
    - Add `"noImplicitAny": true,`
    - Add typeRoots
        ```json
        "typeRoots": [
          "./node_modules/@types"
        ]
        ```            
1. `tsconfig.app.json`: App specific overrides on `tsconfig.json` (eg. when you have multiple apps)
1. `tsconfig.spec.json`: For Tests
    - If you have extra test files, add test files here:
    ```json
      "files": [
        "src/my_extra_test.ts",
      ],
    ```
1. `tsconfig.eslint.json`: For static analysis
    - reference in `.eslintrc.json`


# Karma
- [`karma.conf.js`](http://karma-runner.github.io/6.4/config/configuration-file.html)
    - reference in `angular.json`: `projects.<projectName>.architect.test.options.karmaConfig`
        - `"karmaConfig": "karma.conf.js",`
- WebStorm (Intellij, Goland, ...) support debugging with breakpoints
    - https://www.jetbrains.com/help/webstorm/running-unit-tests-on-karma.html


# Other resources
1. https://angular.io/cli
1. https://angular.io/guide/setup-local
