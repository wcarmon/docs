# Overview
1. Pattern for promise chaining with cancellation


# Example
```ts
export interface PromiseAndCanceller {
  // invoke when you want to stop the tasks
  cancelFn: () => void;

  // resolves to output of last task
  promise: Promise<any>;
}

export const emptyPromiseAndCanceller: PromiseAndCanceller = {
  cancelFn: () => {
  },
  promise: Promise.resolve(),
};

/**
 * Usage:
 *
 *     // -- any func that returns a promise (eg. http fetch call)
 *     const task0 = () => new Promise((resolve, reject) => {...});
 *     const task1 = () => new Promise((resolve, reject) => {...});
 *
 *     const helper = doAsyncTasksWithCancellation(task0, task1);
 *
 *     // Optional: fake a cancellation
 *     setTimeout(() => {
 *       // simulate cancellation after user clicks cancel button
 *       helper.cancelFn();
 *     }, 200);
 *
 *     try {
 *       const outputOfLastTask = await helper.promise;
 *
 *     } catch (e) {
 *       // handle error or cancellation
 *     }
 */
export function doAsyncTasksWithCancellation(
  ...tasks: ((prev: any) => Promise<any>)[]
): PromiseAndCanceller {

  if (!tasks) {
    // nothing to do
    return emptyPromiseAndCanceller;
  }

  const inputForFirstTask = null;

  const rejectFunctions: ((reason?: any) => void)[] = [];

  const cancellationPromise =
    new Promise((_, reject) => rejectFunctions.push(reject));

  return {
    promise: new Promise((resolve, reject) => {
      rejectFunctions.push(reject);

      // -- First step
      let p = tasks[0](inputForFirstTask);

      // allow cancellation to prevent next step
      p = Promise.race([p, cancellationPromise]);

      // -- chain intermediate steps
      for (let i = 1; i < tasks.length; i++) {
        p = p.then((prev) => tasks[i](prev));

        // allow cancellation to prevent next step
        p = Promise.race([p, cancellationPromise]);
      }

      // -- Last step
      p.then((prev) => resolve(prev));
      p.catch(reject);
    }),

    cancelFn: () => {
      for (const rejectFn of rejectFunctions) {
        rejectFn("cancelled");
      }
    },
  };
}
```


# Other resources
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/race
