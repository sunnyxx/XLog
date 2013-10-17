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

//    XLogPredefines macros = XLogGetPredefines;
//    XXLog(@"123 %d");
//    [XLogger logWithOwner:@"xx" level:XLogInfoLevel macros:(XLogPredefines){"s","b",1} format:@"123:%d", 123];
    XXLog(@"1");
    return YES;
}

@end
