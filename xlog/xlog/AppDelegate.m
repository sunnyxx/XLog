//
//  AppDelegate.m
//  xlog
//
//  Created by sunny on 13-9-23.
//
//

#import "AppDelegate.h"
#import "SNSLogging.h"

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
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 10000; i++)
    {
        SYLog(@"1111111");
    }
    CFAbsoluteTime middle = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 10000; i++)
    {
        NSLog(@"-------------");
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"XLog:%lf", middle-start);
    NSLog(@"NSLog:%lf",end-middle);
    
    return YES;
}

@end
