# FDDebugObserver

##Who Moved My Cheese?

An Amazing tool to observe the KeyPath of a Object.

The tool will print the callStackSymbols when the observed keyPath changes.
##How to use?
###add


~~~
    [[FDDebugObserver fd_sharedDebugObserver] fd_addObservedObject:[UIApplication sharedApplication] observedKeyPath:@"idleTimerDisabled"];

~~~

###remove

~~~
    [[FDDebugObserver fd_sharedDebugObserver] fd_removeObservedObject:[UIApplication sharedApplication] observedKeyPath:@"idleTimerDisabled"];

~~~

###log

~~~
    [[FDDebugObserver fd_sharedDebugObserver] fd_logCurrentobserverDictionary];
~~~
