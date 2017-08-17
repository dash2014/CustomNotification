//
//  CustomNotification.h
//  CustomNotification
//
//  Created by dash on 2017/8/7.
//  Copyright © 2017年 dash. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CustomNotification;

typedef void (^CustomNotificationBlock)(CustomNotification * _Nullable noti);

@interface CustomNotification : NSObject

@property (nullable, strong) id observer;
@property (nullable, assign) SEL selector;
@property (readonly, copy) NSString *notificationName;
@property (nullable, readonly, retain) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;
@property (nullable, strong) dispatch_queue_t operationQueue;

- (instancetype)initWithObserver:(nullable id)observer
                        selector:(nullable SEL)aSelector
                notificationName:(NSString *)aName
                          object:(nullable id)anObject
                        userInfo:(nullable NSDictionary *)userInfo
                  operationQueue:(nullable dispatch_queue_t)operationQueue;

@end

NS_ASSUME_NONNULL_END
