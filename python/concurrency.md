# Overview
1. TODO


# Idioms

## IO-Bound
1. Use [coroutines (`async`/`await`)](https://docs.python.org/3/library/asyncio-task.html)


## CPU-Bound Parallelism
1. **Don't** use pure Python for **CPU**-bound parallelism
    1. Because of the [GIL](https://wiki.python.org/moin/GlobalInterpreterLock)        
1. Option-1: Use a c-based Python extension lib like [numpy](https://numpy.org/)
    1. or [numba](https://numba.pydata.org/)
    1. Con: must make your data fit into the array structure
    1. Con: limits on data types you can use
    1. Con: security concerns around using an memory-unsafe language (c)
    1. Pro: Don't need to leave python (assuming you like python)
1. Option-2: [Use go with Goroutines](../golang/concurrency.fanout_fanin.md)
    1. Pro: Simpler than python 
    1. Pro: Faster than python 
    1. Pro: Less memory than python
    1. Con: must switch languages (assuming you like python) 
1. Option-3: [Use rust with rayon](../rust/concurrency.fanout_fanin.md)     
    1. Con: More complex than python and golang
    1. Con: and hard to make cross-compile
    1. Con: must switch languages (assuming you like python)
    1. Pro: Faster than python and golang 
    1. Pro: Less memory than python and golang
1. Option-4: [Use cython](https://cython.readthedocs.io/en/stable/src/userguide/parallelism.html)
    1. TODO: more pros & cons
    1. Con: limits on data types you can use
    1. Con: security concerns around using an memory-unsafe language (c)
    1. Con: more complex & longer build process    
1. Option-5: (Bad) use [multiple processes](https://docs.python.org/3/library/multiprocessing.html)
    1. Con: extra memory overhead
    1. Con: harder to communicate between tasks 
    1. Pro: Don't need to leave python, assuming you like python :-)
1. Option-6: (Bad) use multiple threads
    1. Performance still limited by [GIL](https://wiki.python.org/moin/GlobalInterpreterLock)
    1. Overly complex & error prone code


# Other Resources
1. TODO
