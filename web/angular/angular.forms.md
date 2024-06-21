# Overview
1. Idioms for low maintenance forms


# Why use Angular forms (as opposed to hand rolled form)
1. Angular reactive forms save you time without being invasive (library, not framework)
1. You'd manage data flow ...
    1. Changes from HTML element to model in class
    1. Changes from model in class to HTML element    
1. You'd manage validation, possibly `async` validation too
1. Angular provides **reactive** ways to hook into the form lifecycle (eg. `statusChanges`, `valuesChanges`)
1. Angular adds/removes [css classes](https://angular.io/guide/form-validation#control-status-css-classes) to HTML control element based on state
    1. Either `.ng-valid` or `.ng-invalid` for "validated", (details below)
    1. Either `.ng-dirty` or `.ng-pristine` for "mutated", (details below)
    1. Either `.ng-touched` or `.ng-untouched` for "visited", (details below)


# Reactive Forms vs. ~~Template Forms~~
1. Avoid ~~Template forms~~ because ...
    1. They don't scale
    1. Too much logic in HTML template
    1. Makes HTML template more verbose
    1. Mutability everywhere
    1. Validation uses ~~directives~~, not functions
    1. Harder to test
    1. Harder to reason about data flow


# Cheatsheet
## In component Typescript
1. Make a domain specific [TS interface](https://www.typescriptlang.org/static/TypeScript%20Interfaces-34f1ad12132fb463bd1dfe5b85c5b2e6.png) to model the form entity
1. [Generate an Angular Component for the form](https://v17.angular.io/cli/generate#component-command)
1. Include the ReactiveForms module in your Component:
    - eg. `imports: [ReactiveFormsModule],`
1. Create one [`FormGroup`](https://v17.angular.io/api/forms/FormGroup) instance in component class (one per domain entity)
1. Create multiple [`FormControl`](https://v17.angular.io/api/forms/FormControl) instances in the component class, (one for each entity field)
    1. Add validator functions (see [examples below](./angular.forms.md#validators)) to [formControl.validators](https://angular.dev/api/forms/AbstractControl#setValidators)
1. Add `FormControl` instances to `FormGroup`
    1. Use the **same name** for the TS interface field and `FormGroup` field
1. Add `onSubmit($event: any)` method on component
```ts
  onSubmit($event: Event): void {

    const form = this.formGroup;

    // or if (!form.valid) {
    if (form.invalid) {
      console.debug('rejecting submit for invalid form', form.value);
      return;
    }

    const entity = form.value;

    // TODO: do any normalization/type conversion here

    // TODO: send entity to some service here

    form.reset();
  }
```
1. After submit, [`formGroup.reset()`](https://angular.dev/api/forms/AbstractControl#reset)


## In component HTML Template
1. Create a `<form [formGroup]="myForm">`
    1. Optional attribute: `(ngSubmit)="onSubmit()"`, but not so helpful when you have multiple forms.
1. Create HTML elements for each field (eg. `<input>`, `<select>`, [material components](https://material.angular.io/components/categories), etc)
    1. Gotcha material components only work with [css-grid](https://css-tricks.com/snippets/css/complete-guide-grid/) & [css-flex](https://css-tricks.com/snippets/css/a-guide-to-flexbox/), not `<table>`;
1. On each field, set [`FormControlName`](https://v17.angular.io/api/forms/FormControlName) directive
1. Set `id="..."` attribute on HTML input tag, for deep linking
1. Print Form level errors (or multi field errors)
    1. TODO
1. Print field errors:
```html
  <div *ngIf="fooField.touched && fooField.invalid" class="error">
    <span *ngFor="let errorMsg of Object.values(fooField.errors)">{{ errorMsg }}</span><br/>
  </div>
```
1. Print only specific error(s):
```html
  <span *ngIf="fooField.touched && fooField.hasError(someErrorKey)" class="error">
    TODO: Replace validator message with something custom here
  </span>
```
1. Add `<button (click)="onSubmit(formGroup)" [disabled]="myForm.invalid">`
    1. passing `formGroup` is only useful when you **multiple** forms on the page.
- TODO: if you cannot reach form field, try `formGroup.controls.foo?.errors` or `formGroup.get('foo').errors`

## CSS (Less)
1. use the `ng-` classes to make forms appear responsive
1. Can use animation to transition between states


# [`FormControl`](https://v17.angular.io/api/forms/FormControl)
1. The source of truth for a field value
1. Structure: Field value + Validation Errors + dirty/touched state
1. `FormControl` is mutable, but field value is immutable
    1. Use [`.setValue(...)`](https://v17.angular.io/api/forms/FormControl#setValue) to replace **all** values
    1. Use [`.patchvalue(...)`](https://v17.angular.io/api/forms/FormControl#patchvalue) to replace **some** values
1. Supports multiple errors (think: `Map<ErrorKey, ErrorMessage>`)
1. Supports multiple validators (think function: [`(HTMLControl) => Map<ErrorKey, ErrorMessage>`](https://v17.angular.io/api/forms/ValidatorFn))
1. Supports async validators (think function: `(HTMLControl) => Promise<Map<ErrorKey, ErrorMessage>>`)    
1. TODO: restricting input
1. TODO: gotchas/conflicts with standard html input validation


## Validators
1. Validators are functions
1. Validator fn can return a `Promise` (async validator)
    1. Async validators only run if **all** synchronous validators pass (for performance reasons)
1. Custom validator is just a function, which with [this signature](https://v17.angular.io/api/forms/ValidatorFn)
    1. read value using `control.value`
    1. on success: `return null;`
    1. on failure: `return { someErrorKey: errorMessageText };`
1. Built-in validators
    1. Required: [directive](https://angular.dev/api/forms/RequiredValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L489)
    1. Max (value): [directive](https://angular.dev/api/forms/MaxValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L473)
    1. Min (value): [directive](https://angular.dev/api/forms/MinValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L457)
    1. Max length: [directive](https://angular.dev/api/forms/MaxLengthValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L535)
    1. Min length: [directive](https://angular.dev/api/forms/MinLengthValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L517)
    1. Email: [directive](https://angular.dev/api/forms/EmailValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L506)
    1. Pattern: [directive](https://angular.dev/api/forms/PatternValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L547)
        1. [Official example](https://v17.angular.io/api/forms/Validators#pattern)
		1. Eg. `Validators.pattern('^[a-zA-Z0-9_.+-]+$')`

## CSS classes (Field level)
1. `ng-touched` and `ng-untouched`: field has (not) been touched yet (think [focus](https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event) & [blur](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event))
1. `ng-dirty` and `ng-pristine`: field has (not) been modified yet
1. `ng-valid` and `ng-invalid`: field content is (not) valid (see [Validators](./angular.forms.md#validators) above)


# [`FormGroup`](https://v17.angular.io/api/forms/FormGroup)
1. Aggregates `FormControl`s of different types (Facade pattern)
    1. Tracks `dirty` and `touched` for all child `FormControls`
1. Can be nested
1. Supports [cross-field validation](https://v17.angular.io/guide/form-validation#cross-field-validation)
    1. use [`formGroup.addValidators(...)`](https://v17.angular.io/api/forms/AbstractControl#addvalidators)
1. Idiomatic usage:
    1. Use `FormGroup` to model the domain entity (one per entity)
    1. Use `FormControl` to model the domain entity fields (one per field)
        1. Same names or use [`FormControlName`](https://v17.angular.io/api/forms/FormControlName) directive
    1. Changes: Use [`FormGroup.patchValue`](https://v17.angular.io/api/forms/FormGroup#patchvalue) to update specific field(s)
    1. Changes: Use [`FormGroup.setValue(myEntity)`](https://v17.angular.io/api/forms/FormGroup#setValue) to update entire form
        1 Assumes property names match
    1. Use [`FormGroup.reset()`](https://v17.angular.io/api/forms/FormGroup#reset) on init and after successful form submit
        1. clears the `dirty` and `touched` flags, sets defaults, etc. 

## CSS classes (`FormGroup` level)
1. `ng-touched`: at least one field touched, (or user ["blurred"](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event) the control or control has lost focus)
1. `ng-untouched`: zero fields touched (or control has not lost focus yet)
1. `ng-dirty`: one or more fields changed/modified (user changed value after init or last reset)
1. `ng-pristine`: zero fields modified ([docs](https://angular.dev/api/forms/AbstractControl#pristine))
1. `ng-valid`: all field content valid
1. `ng-invalid`: at least one field has invalid content (see [Validators](./angular.forms.md#validators) above)


# [`ControlValueAccessor`](https://angular.dev/api/forms/ControlValueAccessor) interface
1. Adapter/Bridge between the HTML element and one `FormControl` instance
1. eg. Checkboxes have an atypical way of representing their boolean value


# Simplified getters
```ts
//  in component class

getErrorMessages(foo: MyDomainObject, fieldName: string): string[] {
  const control = foo.formGroup?.controls[fieldName];

  if (!control) {
    console.warn('[MyComponent] failed to find control with name=', fieldName);
    return [];
  }

  if (!control.errors) {
    return [];
  }

  return Object.values(control.errors);
}
```


# Gotchas
1. Async validators only run if all synchronous validators pass (for performance reasons)
1. There's no built in validator for ["isBlank"](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#isBlank())
1. By default, Angular disables all HTML5 `<input>` validation
1. Forms don't use rx, but they are observable
    1. [`formGroup.statusChanges.subscribe(...)`](https://angular.dev/api/forms/FormGroup#statusChanges)
    1. [`formGroup.valueChanges.subscribe(...)`](https://angular.dev/api/forms/FormGroup#valueChanges)


# Other resources
1. [related css classes #1](https://www.c-sharpcorner.com/article/pristine-vs-dirty-touched-vs-untouched-valid-vs-invalid-in-angular/)
1. [related css classes #2](https://stackoverflow.com/questions/25025102/angularjs-difference-between-pristine-dirty-and-touched-untouched)
1. https://angular.dev/api/forms/FormGroup