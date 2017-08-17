//
//  ViewController.m
//  CustomNotification
//
//  Created by dash on 2017/8/7.
//  Copyright © 2017年 dash. All rights reserved.
//

#import "ViewController.h"

#import "CustomNotificationCenter.h"
#import "CustomNotification.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[CustomNotificationCenter defaultCenter] addObserver:self selector:@selector(run:) name:@"a" object:nil userInfo:nil operationQueue:nil];
    
    [[CustomNotificationCenter defaultCenter] addObserver:self selector:@selector(run1:) name:@"b" object:@"1" userInfo:nil operationQueue:nil];
    
    [[CustomNotificationCenter defaultCenter] addObserver:self selector:@selector(run2:) name:@"c" object:nil userInfo:@{@"s":@"1"} operationQueue:nil];
    
    [[CustomNotificationCenter defaultCenter] addObserver:self selector:@selector(run3:) name:@"d" object:nil userInfo:nil operationQueue:nil];
    
    [[CustomNotificationCenter defaultCenter] addObserver:self selector:@selector(run4:) name:@"e" object:nil userInfo:nil operationQueue:dispatch_get_global_queue(0, 0)];
    
    [[CustomNotificationCenter defaultCenter] postNotificationName:@"a" object:nil];
    
}

- (void)run:(NSNotification *)noti
{
    NSLog(@"1111");
    [[CustomNotificationCenter defaultCenter] postNotificationName:@"b" object:@"1"];
}

- (void)run1:(NSNotification *)noti1
{
    [[CustomNotificationCenter defaultCenter] postNotificationName:@"c" object:nil userInfo:@{@"s":@"1"}];
}

- (void)run2:(NSNotification *)noti2
{
     [[CustomNotificationCenter defaultCenter] postNotificationName:@"d" object:nil userInfo:@{@"s":@"1"}];
}

- (void)run3:(NSNotification *)noti3
{
     [[CustomNotificationCenter defaultCenter] postNotificationName:@"e" object:nil userInfo:@{@"s":@"1"}];
}

- (void)run4:(NSNotification *)noti4
{
    NSThread *t = [NSThread currentThread];
    [[CustomNotificationCenter defaultCenter] removeObserver:self name:@"a" object:nil];
    [[CustomNotificationCenter defaultCenter] removeObserver:self name:@"b" object:nil];
    [[CustomNotificationCenter defaultCenter] removeObserver:self name:@"c" object:nil];
    [[CustomNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
