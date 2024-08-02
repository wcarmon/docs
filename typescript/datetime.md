# Overview
- Using dates, times, zones, durations & periods


# Representation
TODO


# Formatting
TODO


# Parsing
TODO


# Current Time
- TODO:

```ts
export function fourPMEasternToday(): Date {
    const todayInET = moment.ts('America/New_York');
    todayInET.set({ hour: 16, minute: 0, second: 0, millisecond: 0});
    return todayInET.toDate();
}

export function secondsUntil4pmET(): number {
    const tz = 'America/New_York';
    const nowInTZ = utcToZonedTime(new Date(), tz);
    
    let fourPmET = setHours(setMinutes(setSeconds(newInTZ, 0), 0), 16);
    if (fourPmET < nowInTZ) {
        fourPmET = addDays(fourPmET, 1);
    }
    
    return differenceInMilliseconds(fourPmET, nowInTZ) / 1000;
}
```


# Parts of year
- TODO


# Parts of day
- TODO


# Before & After
- TODO


# Add/Subtract Durations/Periods
- TODO

```ts
export function nDaysAgo(numDays: number): Date {
    const d = new Date();
    d.setDate(d.getDate() - numDays);
    return d;
}
```


# Java/JVM interop
- TODO


# Rust interop
- TODO


# Timezones
- TODO


# Idioms
- TODO ...



# Other Resources
1. TODO ...
