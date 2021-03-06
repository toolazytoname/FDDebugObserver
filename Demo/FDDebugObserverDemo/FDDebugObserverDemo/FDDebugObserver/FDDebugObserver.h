//
//  FDDebugObserver.h
//  iPhoneVideo
//
//  Created by weichao on 16/7/27.
//  Copyright © 2016年 FG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FDLogBlock)(NSString *log);

/**
 * Who Moved My Cheese?
 *
 * An Amazing tool to observer the KeyPath of a Object.The tool will print the callStackSymbols when the observed keyPath changes.
 *
 * Multiply KeyPaths and objects is supported.
 */
@interface FDDebugObserver : NSObject

/**
 *  init a sharedObserver
 *
 *  @return sharedObserver
 */
+ (FDDebugObserver *)fd_sharedDebugObserver;

/**
 *  add observedObject and observedKeyPath
 *
 *  @param observedObject  object to observer
 *  @param observedKeyPath keyPath of the object to server
 *  @param logBlock        log output block
 */
- (void)fd_addObservedObject:(NSObject *)observedObject
             observedKeyPath:(NSString *)observedKeyPath
                    logBlock:(FDLogBlock)logBlock;

/**
 *  remove observedObject and observedKeyPath
 *
 *  @param observedObject  object to observer
 *  @param observedKeyPath keyPath of the object to server
 */
- (void)fd_removeObservedObject:(NSObject *)observedObject observedKeyPath:(NSString *)observedKeyPath;

/**
 *  log current observedObjects and observedKeyPath
 */
- (void)fd_logCurrentobserverDictionary;

@end
