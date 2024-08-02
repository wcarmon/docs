# Overview
1. TODO


# Blank checks
```ts
export function isBlank(s: string | null | undefined): boolean {
  return (s ?? '').trim().length() === 0;
}

export function isNotBlank(s: string | null | undefined): boolean {
  return (s ?? '').trim().length() > 0;
}
```



# Other resources
1. TODO
