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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* Tests here */ {
        SYLog(@"%@", @"123");
//
//        XLogBase(@"123", XInfoLevel, @"%@", @"123");
    }
    
    return YES;
}
@end
