//
//  CustomNotificationCenter.m
//  CustomNotification
//
//  Created by dash on 2017/8/7.
//  Copyright © 2017年 dash. All rights reserved.
//

#import "CustomNotificationCenter.h"


@interface CustomNotificationCenter()

@property (nonatomic, strong) dispatch_queue_t controlQueue;
@property (nonatomic, copy) NSMutableDictionary <NSString *, NSMutableArray<CustomNotification *> *>*observes;

@end

@implementation CustomNotificationCenter

+ (instancetype)defaultCenter
{
    static id __singleton__ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__singleton__) {
            __singleton__ = [self new];
        }
    });
    return __singleton__;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.controlQueue = dispatch_queue_create("com.dash.operationQueue", DISPATCH_QUEUE_SERIAL);
        
        self.observes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject
           userInfo:(NSDictionary *)userInfo
     operationQueue:(nullable dispatch_queue_t)operationQueue
{
    dispatch_async(self.controlQueue, ^{
        CustomNotification *noti = [[CustomNotification alloc] initWithObserver:observer
                                                                       selector:aSelector notificationName:aName
                                                                         object:anObject
                                                                       userInfo:userInfo operationQueue:operationQueue];
        
        NSMutableArray *tempArray = [self.observes objectForKey:aName].count ? [[self.observes objectForKey:aName] mutableCopy] : [NSMutableArray array];
        for (CustomNotification *noti in tempArray) {
            if ([noti.notificationName isEqualToString:aName]
                && [observer isEqual:noti.observer]
                && [anObject isEqual:noti.object]) {
                return;
            }
        }
        [tempArray addObject:noti];
        NSMutableDictionary *dict = [self.observes mutableCopy];
        [dict setObject:tempArray forKey:aName];
        self.observes = dict;

    });
}

- (void)postNotification:(CustomNotification *)notification
{
    dispatch_async(self.controlQueue, ^{

        NSString *notiName = notification.notificationName;
        NSMutableArray *notis = [self.observes objectForKey:notiName];
        for (int i = 0; i < notis.count; i++) {
            CustomNotification *notification = [notis objectAtIndex:i];
            if ([notification.observer respondsToSelector:notification.selector]) {
                dispatch_async(notification.operationQueue, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [notification.observer performSelector:notification.selector withObject:notification];
#pragma clang diagnostic pop
                });
            } else {
                //什么也不做
            }
        }
    });
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject
{
    CustomNotification *noti = [[CustomNotification alloc] initWithObserver:nil
                                                                   selector:nil
                                                           notificationName:aName
                                                                     object:anObject
                                                                   userInfo:nil
                                                             operationQueue:nil];
    [self postNotification:noti];
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo
{
    CustomNotification *noti = [[CustomNotification alloc] initWithObserver:nil
                                                                   selector:nil
                                                           notificationName:aName
                                                                     object:anObject
                                                                   userInfo:aUserInfo
                                                             operationQueue:nil];
    [self postNotification:noti];
}

- (void)removeObserver:(id)observer
{
    dispatch_async(self.controlQueue, ^{
        if (!observer) {
            [self.observes removeAllObjects];
        }
        for (NSString *key in self.observes) {
            for (CustomNotification *noti in self.observes[key]) {
                if ([observer isEqual:noti.observer]) {
                    NSMutableArray *temp = [self.observes objectForKey:key];
                    [temp removeObject:noti];
                    if (temp.count == 0) {
                        NSMutableDictionary *dict = [self.observes mutableCopy];
                        [dict removeObjectForKey:key];
                        self.observes = dict;
                    } else {
                         NSMutableDictionary *dict = [self.observes mutableCopy];
                        [dict setObject:temp forKey:key];
                        self.observes = dict;
                    }
                }
            }
        }
    });
}
                   
- (void)removeObserver:(id)observer
                   name:(NSString *)aName
                   object:(nullable id)anObject
{
    dispatch_async(self.controlQueue, ^{
        if (!aName) {
            [self.observes removeAllObjects];
            return;
        }
        
        NSMutableArray *notiArray = [self.observes objectForKey:aName];
        if (!observer) {
            [self.observes removeObjectForKey:aName];
        }
        
        for (CustomNotification *noti in notiArray) {
            if ([noti.notificationName isEqualToString:aName]
                && [observer isEqual:noti.observer]) {
                [notiArray removeObject:noti];
                if (notiArray.count == 0) {
                    NSMutableDictionary *dict = [self.observes mutableCopy];
                    [dict removeObjectForKey:aName];
                    self.observes = dict;
                } else {
                    NSMutableDictionary *dict = [self.observes mutableCopy];
                    [dict setObject:notiArray forKey:aName];
                    self.observes = dict;
                }
            }
        }
    });
}


@end
