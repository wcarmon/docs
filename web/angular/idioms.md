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
1. **MUST END WITH TRAILING SLASH**
1. Be consistent
1. If using k8s ingress, use the path as `--base-href`
1. Priority
    1. Highest: `ng build --base-href="..."`  <-- do it here
    1. Middle:  `baseHref` in `angular.json`  <-- do NOT use
    1. Lowest: `<base href="...">` in `index.html`  <-- do NOT use
1. Must add to [`angular.json`](https://angular.io/guide/workspace-config#angular-workspace-configuration)
    1. [`/projects/<project-name>/architect/build/options/baseHref`](https://angular.io/guide/workspace-config#base-href)
    1. Set the `baseHref` here (cli argument in `ng build ...`)
        1. Each configuration can have a different `baseHref`
1. Must add to `index.html`
    1. `<base href="/">` is fine (and is the default)
    1. `<base href="/static/">` is also fine    
    1.  angular-build rewrites the `base`, so default is fine:
        1. See https://github.com/angular/angular-devkit-build-angular-builds/blob/main/src/utils/index-file/augment-index-html.js#L138
    1. See https://angular.io/guide/deployment#the-base-tag


# [Karma](https://angular.io/guide/testing#configuration)
1. See https://angular.io/guide/testing#configuration
1. create/update `karma.conf.js`
1. update `angular.json`
    - `/projects/<project-name>/architect/test/options`


# WebStorm Debugger
- TODO


# WebStorm Test Debugger
- TODO


# Testing

## Components
1. mock dependent components
1. See https://braydoncoyer.dev/blog/mocking-components-in-angular
1. Example
```ts
  @Component({
    selector: 'sub-component',
    template: '',
  })
  class MockTestHelperComponent {}

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RouterTestingModule],
      declarations: [
        AppComponent,
        MockSubComponent,  // AppComponent uses <sub-component> in template
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(AppComponent);
  });
```

# Gotchas
- See [setup.angular.md](./setup.angular.md)      


# Other Resources
1. TODO
