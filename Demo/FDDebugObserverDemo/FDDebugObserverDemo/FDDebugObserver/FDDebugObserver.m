//
//  FDDebugObserver.m
//  iPhoneVideo
//
//  Created by weichao on 16/7/27.
//  Copyright © 2016年 FG. All rights reserved.
//

#import "FDDebugObserver.h"

@interface FDDebugObserver()

/**
 *  @{@"observedKeyPath:%@observedObject:%p": observered Object}
 *
 *  The keys are the result of - (NSString *)keyWithObservedObject:(NSObject *)observedObject observedKeyPath:(NSString *)observedKeyPath {
 *
 *
 *  The values are observed Objects
 */
@property (nonatomic, strong) NSMutableDictionary *observedDictionary;

/**
 *  @{@"observedKeyPath:%@observedObject:%p": logBlock}
 *
 *  The keys are the result of - (NSString *)keyWithObservedObject:(NSObject *)observedObject observedKeyPath:(NSString *)observedKeyPath {
 *
 *
 *  The values are logBlocks
 */
@property (nonatomic, strong) NSMutableDictionary *logBlockDictionary;

@end

@implementation FDDebugObserver

+ (FDDebugObserver *)fd_sharedDebugObserver {
    static dispatch_once_t onceToken;
    static FDDebugObserver *debugObserver;
    dispatch_once(&onceToken, ^{
        debugObserver = [[FDDebugObserver alloc] init];
    });
    return debugObserver;
}

- (void)fd_addObservedObject:(NSObject *)observedObject
             observedKeyPath:(NSString *)observedKeyPath
                    logBlock:(FDLogBlock)logBlock {
    if (!observedKeyPath || !(observedKeyPath.length > 0) || !observedObject) {
        NSLog(@"[FDDebugObserver] The keyPath or observer is invalid.");
        return;
    }
    
    if(!logBlock) {
        NSLog(@"[FDDebugObserver] The logBlock is invalid.");
        return;
    }
    
    NSString *key = [self keyWithObservedObject:observedObject observedKeyPath:observedKeyPath];
    //already observed
    NSArray *keys = [self.observedDictionary allKeys];
    if ([keys containsObject:key]) {
        NSLog(@"[FDDebugObserver] The observedObject:%@ and corresponding observedKeyPath:%@ is already observed",observedObject,observedKeyPath);
        return;
    }
    
    [observedObject addObserver:self forKeyPath:observedKeyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionNew context:nil];
    [self.observedDictionary setObject:observedObject forKey:key];
    [self.logBlockDictionary setObject:logBlock forKey:key];
}

- (void)fd_removeObservedObject:(NSObject *)observedObject observedKeyPath:(NSString *)observedKeyPath {
    if (!observedKeyPath || !(observedKeyPath.length > 0) || !observedObject) {
        NSLog(@"[FDDebugObserver] The keyPath or observer is invalid.");
        return;
    }
    @try {
        [observedObject removeObserver:self forKeyPath:observedKeyPath];
        
        NSString *key = [self keyWithObservedObject:observedObject observedKeyPath:observedKeyPath];
        [self.observedDictionary removeObjectForKey:key];
        [self.logBlockDictionary removeObjectForKey:key];
    } @catch (NSException *exception) {
        NSLog(@"[FDDebugObserver] exception:%@",exception);
    }
}

- (void)fd_logCurrentobserverDictionary {
    NSLog(@"[FDDebugObserver] observedDictionary:%@;\nlogBlockDictionary:%@",self.observedDictionary,self.logBlockDictionary);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSString *key = [self keyWithObservedObject:object observedKeyPath:keyPath];
    NSArray *keys = [self.observedDictionary allKeys];
    if ([keys containsObject:key]) {
        NSString *log = [NSString stringWithFormat:@"[FDDebugObserver] Who Moved %@'s %@ ? callStackSymbols:%@",object,keyPath,[NSThread callStackSymbols]];
        FDLogBlock logBlock = [self.logBlockDictionary objectForKey:key];
        if (logBlock) {
            logBlock(log);
        }
    }
}

- (NSString *)keyWithObservedObject:(NSObject *)observedObject
                observedKeyPath:(NSString *)observedKeyPath {
    if (!observedObject || !observedKeyPath || !(observedKeyPath.length > 0)) {
        return nil;
    }
    NSString *key = [NSString stringWithFormat:@"observedKeyPath:%@observedObject:%p",observedKeyPath,observedObject];
    return key;
}
#pragma mark lazyLoader
- (NSMutableDictionary *)observedDictionary {
    if (!_observedDictionary) {
        _observedDictionary = [[NSMutableDictionary alloc] init];
    }
    return _observedDictionary;
}

- (NSMutableDictionary *)logBlockDictionary {
    if (!_logBlockDictionary) {
        _logBlockDictionary = [[NSMutableDictionary alloc] init];
    }
    return _logBlockDictionary;
}
@end
