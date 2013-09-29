//
//  AppDelegate.m
//  xlog
//
//  Created by sunny on 13-9-23.
//
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    XLog(@"ALL", @"%@,%@", @"123", @"123123");
    SYLog(@"%@,%d", @"223332323", 1);
    CGRect rect = CGRectMake(0, 0, 100, 200);
    SYLog(@"rect:%@", XRect(rect));
    ZHLog(@"zhou hua");
    ZZYLog(@"zzy");
    TSCLog(@"321123123123,%@", XRect(self.window.frame));
    
    
    return YES;
}

@end
