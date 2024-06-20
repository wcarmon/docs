# Overview
1. Idioms for low maintenance 


# Why use Angular forms (as opposed to hand rolled)
1. You'd have to manage data flow ...
    1. Changes from HTML element to model in class
    1. Changes from model in class to HTML element    
1. You'd have to manage validation, possibly async validation too
1. Angular provides reactive ways to hook into the form lifecycle (eg. `statusChanges`, `valuesChanges`)
1. Angular adds/removes [css classes](https://angular.io/guide/form-validation#control-status-css-classes) to HTML control element based on state
    1. `.ng-valid`/`.ng-invalid`, `.ng-dirty`/`.ng-pristine`, `ng.-touched`/`.ng-untouched` 


## CSS classes (FormGroup level)
1. `ng-touched`: at least one field touched, (or user ["blurred"](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event) the control or control has lost focus)
1. `ng-untouched`: zero fields touched (or control has not lost focus yet)
1. `ng-dirty`: one or more fields changed/modified (user changed value after init or last reset)
1. `ng-pristine`: zero fields modified ([docs](https://angular.dev/api/forms/AbstractControl#pristine))
1. `ng-valid`: all field content valid
1. `ng-invalid`: at least one field has invalid content (see [Validators](TODO) below)

- TODO: ng-valid-key    One key for each validation.
    - Example: ng-valid-required, useful when there are more than one thing that must be validated
- TODO: ng-valid-key    One key for each validation.
    - Example: ng-valid-required, useful when there are more than one thing that must be validated

## CSS classes (Field level)
1. `ng-touched` and `ng-untouched`: field has (not) been touched yet
1. `ng-dirty` and `ng-pristine`: field has (not) been modified yet
1. `ng-valid` and `ng-invalid`: field content is (not) valid (see [Validators](TODO) below)



# Cheatsheet
## Typescript
1. Make a domain specific [TS interface](https://www.typescriptlang.org/static/TypeScript%20Interfaces-34f1ad12132fb463bd1dfe5b85c5b2e6.png) to model the form entity
1. [Generate a component for the form](https://v17.angular.io/cli/generate#component-command)
1. Include ReactiveForms module in your Component: eg. `imports: [ReactiveFormsModule],`
1. Create one [`FormGroup`](https://v17.angular.io/api/forms/FormGroup) instance in component class (per domain entity)
1. Create [`FormControl`](https://v17.angular.io/api/forms/FormControl) instance in component class, for each field
    1. Add validator functions (see examples below) to [formControl.validators](https://angular.dev/api/forms/AbstractControl#setValidators)
1. Add `FormControl` instances to `FormGroup`
    1. Use the same name for the TS interface field and `FormGroup` field
1. Add `onSubmit` method on component
```ts
  onSubmit(): void {

    if (!formGroup.valid) {
      console.debug('rejecting submit for invalid form', formGroup.value);
      return;
    }

    const entity = formGroup.value;

    // TODO: do any normalization/type conversion here

    // TODO: send entity to some service here

    formGroup.reset();
  }
```
1. After submit, [`formGroup.reset()`](https://angular.dev/api/forms/AbstractControl#reset)


## HTML
1. Create a `<form [formGroup]="myForm">`
    1. Optional: `(ngSubmit)="onSubmit()"`, not helpful when you have multiple forms though
1. Create HTML elements for each field (eg. `<input>`, `<select>`, etc)
1. On each field, set [`FormControlName`](https://v17.angular.io/api/forms/FormControlName) directive
1. Set `id="..."` attribute on HTML input tag, for deep linking
1. Print Form level errors (or multi field errors)
    1. TODO
1. Print all field errors
```html
  <div *ngIf="fooField.touched && fooField.invalid" class="error">
    <span *ngFor="let errorMsg of Object.values(fooField.errors)">{{ errorMsg }}</span><br/>
  </div>
```
    1. TODO: if cannot reach form field, try `formGroup.controls.foo?.errors` or `formGroup.get('foo').errors`
1. Print specific error(s)
```html
  <span *ngIf="fooField.touched && fooField.hasError(someErrorKey)" class="error">
    TODO: Replace validator message with something custom here
  </span>
```
1. `<button (click)="onSubmit($event)" [disabled]="!myForm.valid">`


## CSS (Less)
1. use the `ng-` classes to make forms appear responsive 
 

# Reactive Forms vs. ~~Template Forms~~
1. Avoid ~~Template forms~~ because ...
    1. They don't scale
    1. Too much logic in HTML template
    1. More verbose HTML template
    1. Mutability everywhere
    1. Validation uses directives, not functions
    1. Harder to test
    1. Harder to reason about data flow


# [`FormControl`](https://v17.angular.io/api/forms/FormControl)
1. The source of truth for field value
1. Structure: Field value + Validation Errors + dirty/touched state
1. `FormControl` is mutable, but field value is immutable
    1. Use [`.setValue(...)`](https://v17.angular.io/api/forms/FormControl#setValue) to replace **all** values
    1. Use [`.patchvalue(...)`](https://v17.angular.io/api/forms/FormControl#patchvalue) to replace **some** values
1. Supports multiple errors (think: `Map<ErrorKey, ErrorMessage>`)
1. Supports multiple validators (think function: [`(HTMLControl) => Map<ErrorKey, ErrorMessage>`](https://v17.angular.io/api/forms/ValidatorFn))
1. Supports async validators (think function: `(HTMLControl) => Promise<Map<ErrorKey, ErrorMessage>>`)    
1. TODO: restricting input


## Validators
1. Validators are functions
1. Validator fn can return a `Promise` (async validator)
    1. Async validators only run if all synchronous validators pass (for performance reasons)
1. Custom validator is just a function, which with [this signature](https://v17.angular.io/api/forms/ValidatorFn)
    1. read value using `control.value`
    1. success: `return null;`
    1. failure: `return { someErrorKey: errorMessageText }`
1. Built-in validators
    1. Required: [directive](https://angular.dev/api/forms/RequiredValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L489)
    1. Max (value): [directive](https://angular.dev/api/forms/MaxValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L473)
    1. Min (value): [directive](https://angular.dev/api/forms/MinValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L457)
    1. MaxLength: [directive](https://angular.dev/api/forms/MaxLengthValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L535)
    1. MinLength: [directive](https://angular.dev/api/forms/MinLengthValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L517)
    1. EmailValidator: [directive](https://angular.dev/api/forms/EmailValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L506)
    1. Pattern: [directive](https://angular.dev/api/forms/PatternValidator), [sources](https://github.com/angular/angular/blob/main/packages/forms/src/validators.ts#L547)
        1. [Official example](https://v17.angular.io/api/forms/Validators#pattern)
		1. Eg. `Validators.pattern('^[a-zA-Z0-9_.+-]+$')`


# [`FormGroup`](https://v17.angular.io/api/forms/FormGroup)
1. Aggregates `FormControl`s of different types (Facade pattern)
    1. Tracks `dirty` and `touched` for all child `FormControls`
1. Can be nested
1. Supports [cross-field validation](https://v17.angular.io/guide/form-validation#cross-field-validation) 
1. Idiomatic usage:    
    1. Use `FormGroup` to model the domain entity (one per entity)
    1. Use `FormControl` to model the domain entity fields (one per field)
        1. Same names or use [`FormControlName`](https://v17.angular.io/api/forms/FormControlName) directive
    1. Use [`FormGroup.setValue(myEntity)`](https://v17.angular.io/api/forms/FormGroup#setValue) to update entire form
        1 Assumes property names match
    1. Use [`FormGroup.patchValue`](https://v17.angular.io/api/forms/FormGroup#patchvalue) to update specific fields
    1. Use [`FormGroup.reset()`](https://v17.angular.io/api/forms/FormGroup#reset) on init and after successful form submit
        1. clears the `dirty` and `touched` flags, sets defaults, etc. 


# [`ControlValueAccessor`](https://angular.dev/api/forms/ControlValueAccessor) interface
1. Adapter/Bridge between the HTML element and one `FormControl` instance
1. eg. Checkboxes have an atypical way of representing their boolean value


# Gotchas
1. Async validators only run if all synchronous validators pass (for performance reasons)
1. There's no built in validator for "isBlank"
1. By default Angular disables all HTML5 `<input>` validation
1. Forms don't use rx, but they are observable


# Other resources
1. [related css classes](https://www.c-sharpcorner.com/article/pristine-vs-dirty-touched-vs-untouched-valid-vs-invalid-in-angular/)
1. [related css classes](https://stackoverflow.com/questions/25025102/angularjs-difference-between-pristine-dirty-and-touched-untouched)
1. https://angular.dev/api/forms/FormGroup