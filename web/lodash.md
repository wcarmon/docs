# Overview
1. How to use lodash in Typescript



# package.json
```json
dependencies {
    ...
    "lodash": "~4.17.21",
    "lodash-es": "~4.17.21",
    ...
}
```


# Usage in code
```ts
import { sortBy } from 'lodash';

function foo(myArray: Foo[]) {

    const result = sortBy(myArray,
        (thing: Foo) => thing.someDateField.getTime(),
        (thing: Foo) => thing.someString,
    );
    
    ...
}
```
