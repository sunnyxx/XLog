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
    
    SYLog(@"logging"@"!!!");
    SYWarning(@"warning!!");
    SYError(@"error!!!!");
    
    CSLog(@"logging!!!");
    CSWarning(@"warning!!");
    CSError(@"error!!!!");

    return YES;
}

@end
