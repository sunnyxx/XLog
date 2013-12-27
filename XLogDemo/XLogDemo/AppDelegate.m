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

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *rootVC = [[UIViewController alloc] init];
    rootVC.view.backgroundColor = [UIColor grayColor];
    [self.window addSubview:rootVC.view];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
        
    /* Tests here */ {
        //        NSTimeInterval NSLogTime = [self executeTimeOfBlock:^{
        //            NSLog(@"123:%d", 123);
        //        }];
        //        NSTimeInterval XLogTime = [self executeTimeOfBlock:^{
        //            SYLog(@"123:%d", 123);
        //        }];
        //        SYLog(@"%lf,%lf", NSLogTime, XLogTime);
        CGRect rect = CGRectMake(1, 2, 3, 4);
        XLog(@"rect:%R", rect);
        XLog(@"point:%P", rect.origin);
        XWarning(@"size:%S", rect.size);
        XError(@"selector:%SEL", _cmd);
        UIView *view1 = [UIView new];
        UIView *view2 = [UIView new];
        [view1 addSubview:view2];
        XLog(@"view:%V,123123", view1);
    }
    
    return YES;
}
@end
