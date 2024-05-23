# Overview
1. Idioms for low maintenance 


# Why use Angular forms (as opposed to hand rolled)
1. You'd have to manage data flow ...
    1. Changes from HTML element to model in class
    1. Changes from model in class to HTML element    
1. You'd have to manage validation    
1. Angular adds/removes [css classes](https://angular.io/guide/form-validation#control-status-css-classes) to HTML control element based on state
    1. `.ng-valid`/`.ng-invalid`, `.ng-dirty`/`.ng-pristine`, `ng.-touched`/`.ng-untouched` 


# Reactive Forms vs. ~~Template Forms~~
1. Avoid template forms because
    1. 


# [FormControl](TODO)


# [FormGroup](TODO)
1. Make a domain specific interface to model the form controls
1. Supports [cross-field validation](https://v17.angular.io/guide/form-validation#cross-field-validation) 
1. 
1. Use [`FormGroup:setValue(myEntity)`](TODO) to update entire form
    1 Assumes property names match
1. Use [`FormGroup::reset()`](TODO) on init and after successful form submit
    1. clears the `dirty` and `touched` flags, sets defaults, etc. 


# Gotchas
1. Async validators only run if all synchronous validators pass (for performance reasons)
1. There's no built in validator for "isBlank"
1. By default Angular disables all HTML5 `<input>` validation


# Other resources
