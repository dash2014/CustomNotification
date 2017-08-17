//
//  CustomNotificationCenter.h
//  CustomNotification
//
//  Created by dash on 2017/8/7.
//  Copyright © 2017年 dash. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomNotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomNotificationCenter : NSObject

+ (instancetype)defaultCenter;

- (void)addObserver:(nonnull id)observer
           selector:(SEL _Nullable )aSelector
               name:(NSString *)aName
             object:(nullable id)anObject
           userInfo:(nullable NSDictionary *)userInfo
     operationQueue:(nullable dispatch_queue_t)operationQueue;

- (void)postNotification:(CustomNotification *)notification;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;

- (void)removeObserver:(id)observer
                  name:(NSString *)aName
                object:(nullable id)anObject;


NS_ASSUME_NONNULL_END

@end
