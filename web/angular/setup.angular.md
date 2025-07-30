# Overview

1. How to setup [Angular](https://angular.io/) and [Angular CLI](https://angular.dev/tools/cli)

# NodeJS

- See [setup doc](../setup.node.md)

# Install pnpm
- https://pnpm.io/installation


# NG

```bash
pnpm self-update
pnpm setup
pnpm install -g @angular/cli
```


# FS watchers
```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf;
sudo sysctl -p --system
```


# New Angular app

```bash
cd /path/to/web/projects

# replace the line below
APP_NAME=some-app

ng new $APP_NAME --package-manager=pnpm
# follow the prompts:   eg. enable routing, use less, ...

ng add @angular/material
```

## Verify

```bash
cd $APP_NAME
# ng serve --open
pnpm start
```


# package.json

```
pnpm i --save @sherifmagdy/animejs
pnpm i --save auto-bind
pnpm i --save dayjs
pnpm i --save lodash-es
pnpm i --save normalize.css
pnpm i --save rxjs
pnpm i --save toastify-js
pnpm i --save uuid
# pnpm i --save notyf

pnpm i --save-dev chai
pnpm i --save-dev chance
pnpm i --save-dev eslint

pnpm i --save-dev jasmine
pnpm i --save-dev jasmine-spec-reporter

pnpm i --save-dev karma
pnpm i --save-dev karma-chrome-launcher
pnpm i --save-dev karma-coverage
pnpm i --save-dev karma-firefox-launcher
pnpm i --save-dev karma-jasmine
pnpm i --save-dev karma-jasmine-html-reporter
pnpm i --save-dev karma-junit-reporter

pnpm i --save-dev mocha
pnpm i --save-dev prettier

# pnpm i --save-dev chalk
# pnpm i --save-dev colors
# pnpm i --save-dev mkdirp
```

1. in package.json, replace `^` with `~`


# [angular.json](https://angular.io/guide/workspace-config) (Angular workspace config)

1. GOTCHA: The format/structure changes between versions
1. Add your global styles
    - Add to:  projects.<projectName&gt;.architect.build.options.styles
    - Add to:  projects.<projectName&gt;.architect.test.options.styles

```json
"styles": [
  "node_modules/normalize.css/normalize.css",
  "node_modules/toastify-js/src/toastify.css",
],
```

1. Change the [`prefix`](https://angular.io/guide/workspace-config#project-configuration-options) to match your app
    - or just leave as "app"
1. Package Manager
```json
{
  ...
  "cli": {
    "packageManager": "pnpm"
  }
}
```



# tsconfig

- See https://angular.io/config/tsconfig
- See https://www.typescriptlang.org/docs/handbook/tsconfig-json.html
- All are used only at CI/Build-time (not runtime)

## Files

1. `tsconfig.json`: Global
    - Add any extra ES features to [`compilerOptions.lib`](https://www.typescriptlang.org/tsconfig#individual-library-components)
        - "ES2018.promise"
        - "ES2023.collection"
        - 'ES2022'
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
    - Sometimes you have to add a breakpoint to force karma plugin to rebuild & deploy tests
    - GOTCHA: compilation errors sometimes appear as test success (no tests found)

# Gotchas

1. Angular material doesn't work with html tables, must use [CSS Flex](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
    1. eg. [MatSelect](TODO)
1. When there's an error in `app.module.ts`, most of the errors are misleading
1. [`app.module.ts`](https://angular.io/guide/architecture-modules) cannot import forms from a [barrel file](https://basarat.gitbook.io/typescript/main-1/barrel)
1. Components and Services need [`autoBind(this);`](https://www.npmjs.com/package/auto-bind)
1. Don't use ~~ActivatedRoute~~, subscribe to Router events instead


# Disable local cli cache
1. `ng serve` doesn't always update the code in the browser, which wastes my time!
```bash
ng config cli.cache.enabled false
```


# Other Resources

1. https://angular.io/cli
1. https://angular.io/guide/setup-local
