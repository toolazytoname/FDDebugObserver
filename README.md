# FDDebugObserver

## Who Moved My Cheese?

An Amazing tool to observe the KeyPath of an Object.

The tool will print the callStackSymbols when the observed keyPath changes.

Multiple KeyPaths and objects are supported.

##  How to use?

Add code as follows,the logBlock will output log when observed keyPath changes.

### add

~~~
[[FDDebugObserver fd_sharedDebugObserver] fd_addObservedObject:[UIApplication sharedApplication]
     observedKeyPath:@"idleTimerDisabled"
     logBlock:^(NSString *log) {
         NSLog(@"log:%@",log);
     }];
~~~

The output of running the demo:

~~~
2016-08-05 18:13:10.423 FDDebugObserverDemo[332:66339] log:[FDDebugObserver] Who Moved <UIApplication: 0x12ee0b0f0>'s idleTimerDisabled ? callStackSymbols:(
	0   FDDebugObserverDemo                 0x0000000100101d34 -[FDDebugObserver observeValueForKeyPath:ofObject:change:context:] + 356
	1   Foundation                          0x000000018140bf64 <redacted> + 304
	2   Foundation                          0x000000018140ba8c <redacted> + 404
	3   Foundation                          0x00000001814b61ac <redacted> + 732
	4   Foundation                          0x000000018140afc0 <redacted> + 64
	5   Foundation                          0x00000001814b2ef4 <redacted> + 272
	6   FDDebugObserverDemo                 0x00000001001011b4 -[ViewController changeValue:] + 196
	7   UIKit                               0x0000000185c9cbe8 <redacted> + 100
	8   UIKit                               0x0000000185c9cb64 <redacted> + 80
	9   UIKit                               0x0000000185c84870 <redacted> + 436
	10  UIKit                               0x0000000185c9c454 <redacted> + 572
	11  UIKit                               0x0000000185c9c084 <redacted> + 804
	12  UIKit                               0x0000000185c94c20 <redacted> + 784
	13  UIKit                               0x0000000185c6504c <redacted> + 248
	14  UIKit                               0x0000000185c63628 <redacted> + 6568
	15  CoreFoundation                      0x0000000180ac509c <redacted> + 24
	16  CoreFoundation                      0x0000000180ac4b30 <redacted> + 540
	17  CoreFoundation                      0x0000000180ac2830 <redacted> + 724
	18  CoreFoundation                      0x00000001809ecc50 CFRunLoopRunSpecific + 384
	19  GraphicsServices                    0x00000001822d4088 GSEventRunModal + 180
	20  UIKit                               0x0000000185cce088 UIApplicationMain + 204
	21  FDDebugObserverDemo                 0x0000000100102554 main + 124
	22  libdyld.dylib                       0x000000018058a8b8 <redacted> + 4
)

~~~

### remove

You can remove it when you do not want to observer anymore.

~~~
    [[FDDebugObserver fd_sharedDebugObserver] fd_removeObservedObject:[UIApplication sharedApplication] observedKeyPath:@"idleTimerDisabled"];

~~~

### log

This method aims to log the dictionary inside for the convenience of debugging.

~~~
    [[FDDebugObserver fd_sharedDebugObserver] fd_logCurrentobserverDictionary];
~~~

The output of running the demo:

~~~
2016-08-05 19:24:14.587 FDDebugObserverDemo[332:66339] [FDDebugObserver] observedDictionary:{
    "observedKeyPath:idleTimerDisabledobservedObject:0x12ee0b0f0" = "<UIApplication: 0x12ee0b0f0>";
};
logBlockDictionary:{
    "observedKeyPath:idleTimerDisabledobservedObject:0x12ee0b0f0" = "<__NSGlobalBlock__: 0x1001040d0>";
}

~~~



## Installation

FDCache is available through [CocoaPods](https://cocoapods.org). To install

it, simply add the following line to your Podfile:



``` ruby
source 'https://github.com/CocoaPods/Specs.git'  # 官方库

source 'https://github.com/toolazytoname/Specs.git'#懒得起名私有库

platform :ios, '8.0'

target "TargetName" do

pod 'FDDebugObserver'

end

```





##  Author



toolazytoname, lazywc@gmail.com

##  License



FDCache is available under the MIT license. See the LICENSE file for more info.