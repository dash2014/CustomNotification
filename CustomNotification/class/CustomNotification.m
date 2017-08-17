//
//  CustomNotification.m
//  CustomNotification
//
//  Created by dash on 2017/8/7.
//  Copyright © 2017年 dash. All rights reserved.
//

#import "CustomNotification.h"

@interface CustomNotification ()

@property (nullable, copy) NSString *notificationName;
@property (nullable, retain) id object;
@property (nullable, copy) NSDictionary *userInfo;

@end

@implementation CustomNotification

- (instancetype)initWithObserver:(id)observer
                        selector:(SEL)aSelector
                notificationName:(NSString *)aName
                          object:(id)anObject
                        userInfo:(NSDictionary *)userInfo
                  operationQueue:(dispatch_queue_t)operationQueue
{
    if (self = [super init]) {
        self.observer = observer;
        self.selector = aSelector;
        self.notificationName = aName;
        self.object = anObject;
        self.userInfo = userInfo;
        self.operationQueue = operationQueue ?: dispatch_get_main_queue();
    }
    return self;
}

@end
