//
//  AppDelegate.m
//  XLogDemo
//
//  Created by sunny on 13-10-18.
//  Copyright (c) 2013年 sunnyxx. All rights reserved.
//

#import "AppDelegate.h"
#import "SNSLogging.h"

@implementation AppDelegate

- (NSTimeInterval)executeTimeOfBlock:(dispatch_block_t)block
{
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 10000; i++)
    {
        block();
    }
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    return end - start;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* Tests here */ {
//        NSTimeInterval NSLogTime = [self executeTimeOfBlock:^{
//            NSLog(@"123:%d", 123);
//        }];
//        NSTimeInterval XLogTime = [self executeTimeOfBlock:^{
//            SYLog(@"123:%d", 123);
//        }];
//        SYLog(@"%lf,%lf", NSLogTime, XLogTime);
        CGRect rect = CGRectMake(0, 0, 100, 200);
//        CGPoint point = rect.origin;
        XLog(@"rect:%R,point:%P, size:%S", rect, rect.origin, rect.size);
        XLog(@"selector:%@", NSStringFromSelector(_cmd));
        XLog(@"selector:%S,%SEL",rect.size, _cmd);
    }
    
    return YES;
}
@end
