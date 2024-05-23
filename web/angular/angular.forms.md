# Overview
1. Idioms for low maintenance 


# Why use Angular forms (as opposed to hand rolled)
1. You'd have to manage data flow ...
    1. Changes from HTML element to model in class
    1. Changes from model in class to HTML element    
1. You'd have to manage validation
1. Angular provides reactive ways to hook into the form lifecycle (eg. `statusChanges`, `valuesChanges`)
1. Angular adds/removes [css classes](https://angular.io/guide/form-validation#control-status-css-classes) to HTML control element based on state
    1. `.ng-valid`/`.ng-invalid`, `.ng-dirty`/`.ng-pristine`, `ng.-touched`/`.ng-untouched` 


# Reactive Forms vs. ~~Template Forms~~
1. Avoid template forms because ...
    1. They don't scale
    1. Too much logic in HTML template
    1. More verbose HTML template
    1. Mutability everywhere
    1. Validation uses directives, not functions
    1. Harder to test
    1. Harder to reason about data flow


# [FormControl](TODO)
1. 


# [FormGroup](TODO)
1. Aggregates `FormControl`s of different types (Facade pattern)
    1. Tracks `dirty` and `touched` for all child `FormControls`
1. Can be nested
1. Supports [cross-field validation](https://v17.angular.io/guide/form-validation#cross-field-validation) 
1. 
1. Idiomatic usage: 
    1. Make a domain specific interface to model the form controls
    1. Use `FormGroup` to model the domain entity
    1. Use `FormControl` to model the domain entity fields
        1. Same names or use [`FormControlName`](TODO) directive
    1. Use [`FormGroup:setValue(myEntity)`](TODO) to update entire form
        1 Assumes property names match
    1. Use [`FormGroup::reset()`](TODO) on init and after successful form submit
        1. clears the `dirty` and `touched` flags, sets defaults, etc. 


# Gotchas
1. Async validators only run if all synchronous validators pass (for performance reasons)
1. There's no built in validator for "isBlank"
1. By default Angular disables all HTML5 `<input>` validation


# Definitions
1. `dirty`: user changed value after init or last reset
1. `touched`: user ["blurred"](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event) the control


# Other resources
