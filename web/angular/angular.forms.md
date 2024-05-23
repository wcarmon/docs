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


# Cheatsheet
1. Typescript
    1. Create a component
    1. Create one `FormGroup` instance in component class
    1. Create `FormControl` instance in component class, for each field
    1. Add `FormControl` instances to `FormGroup`
    1. 
1. HTML
    1. Create a `<form [formGroup]="myForm">`
    1. Create HTML elements for each field (eg. `<input>`, `<select>`, etc)
    1. On each field, set [`FormControlName`](https://v17.angular.io/api/forms/FormControlName) directive
    1. Set `id="..."` attribute on HTML input tag, for deep linking
 

# Reactive Forms vs. ~~Template Forms~~
1. Avoid template forms because ...
    1. They don't scale
    1. Too much logic in HTML template
    1. More verbose HTML template
    1. Mutability everywhere
    1. Validation uses directives, not functions
    1. Harder to test
    1. Harder to reason about data flow


# [`FormControl`](https://v17.angular.io/api/forms/FormControl)
1. The source of truth
1. Structure: Field value + Validation Errors + dirty/touched state
1. `FormControl` is mutable, but field value is immutable
    1. See [`.setValue(...)`](https://v17.angular.io/api/forms/FormControl#setValue)
    1. See [`.patchvalue(...)`](https://v17.angular.io/api/forms/FormControl#patchvalue)
1. Supports multiple errors (think: `Map<ErrorKey, ErrorMessage>`)
1. Supports multiple validators (think function: `(HTMLControl) => Map<ErrorKey, ErrorMessage>`)
1. Supports async validators (think function: `(HTMLControl) => Promise<Map<ErrorKey, ErrorMessage>>`)    
1. TODO: restricting input


# [`FormGroup`](https://v17.angular.io/api/forms/FormGroup)
1. Aggregates `FormControl`s of different types (Facade pattern)
    1. Tracks `dirty` and `touched` for all child `FormControls`
1. Can be nested
1. Supports [cross-field validation](https://v17.angular.io/guide/form-validation#cross-field-validation) 
1. Idiomatic usage: 
    1. Make a domain specific interface to model the form controls
    1. Use `FormGroup` to model the domain entity 
    1. Use `FormControl` to model the domain entity fields
        1. Same names or use [`FormControlName`](https://v17.angular.io/api/forms/FormControlName) directive
    1. Use [`FormGroup:setValue(myEntity)`](TODO) to update entire form
        1 Assumes property names match
    1. Use [`FormGroup::reset()`](TODO) on init and after successful form submit
        1. clears the `dirty` and `touched` flags, sets defaults, etc. 


# [`ControlValueAccessor`](https://angular.dev/api/forms/ControlValueAccessor) interface
1. Adapter/Bridge between the HTML element and one `FormControl` instance
1. eg. Checkboxes have an atypical way of representing their boolean value


# Gotchas
1. Async validators only run if all synchronous validators pass (for performance reasons)
1. There's no built in validator for "isBlank"
1. By default Angular disables all HTML5 `<input>` validation
1. Forms don't use rx, but they are observable


# Definitions
1. `dirty`: user changed value after init or last reset
1. `touched`: user ["blurred"](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event) the control


# Other resources
