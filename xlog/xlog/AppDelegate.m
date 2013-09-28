//
//  AppDelegate.m
//  xlog
//
//  Created by sunny on 13-9-23.
//
//

#import "AppDelegate.h"
#import "xlog.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    XLog(@"sy", @"%@,%@", @"123", @"123123");
    SYLog(@"%@,%d", @"223332323", 1);
    CGRect rect = CGRectMake(0, 0, 100, 200);
    SYLog(@"rect:%@", XRect(rect));
    
    return YES;
}

@end
