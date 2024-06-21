# Overview
- Idioms for using js/ts maps


# Idioms
TODO ...


# Iteration
```ts
for (const [key, value] of m) {
  console.info(key, "=", value)
}

// or

for (const [key, value] of myMap.entries()) {
  console.info(key, "=", value)
}

// or 

myMap.forEach((value, key) => {
    console.info(key, "=", value)
})
```


# Other Resources
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map/forEach
