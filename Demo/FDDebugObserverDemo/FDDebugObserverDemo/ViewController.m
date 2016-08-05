//
//  ViewController.m
//  FDDebugObserverDemo
//
//  Created by weichao on 16/7/27.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "ViewController.h"
#import "FDDebugObserver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)changeValue:(id)sender {
    [UIApplication sharedApplication].idleTimerDisabled = ![UIApplication sharedApplication].idleTimerDisabled;
}

- (IBAction)add:(id)sender {
    [[FDDebugObserver fd_sharedDebugObserver] fd_addObservedObject:[UIApplication sharedApplication]
     observedKeyPath:@"idleTimerDisabled"
     logBlock:^(NSString *log) {
         NSLog(@"log:%@",log);
     }];
}

- (IBAction)remove:(id)sender {
    [[FDDebugObserver fd_sharedDebugObserver] fd_removeObservedObject:[UIApplication sharedApplication] observedKeyPath:@"idleTimerDisabled"];
}
- (IBAction)log:(id)sender {
    [[FDDebugObserver fd_sharedDebugObserver] fd_logCurrentobserverDictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
